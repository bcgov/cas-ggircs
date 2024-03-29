const path = require("path");
const { Storage } = require("@google-cloud/storage");
const argv = require("yargs").argv;
const fs = require("fs");

const fetch = {
  "http:": require("http"),
  "https:": require("https"),
};

const storage = new Storage();

const BUCKET_NAME = argv.bucket;
const bucket = storage.bucket(BUCKET_NAME);

const FILE_URLS = Array.isArray(argv.url)
  ? argv.url
  : (argv.url && [argv.url]) || [];
const USER = process.env.USER;
const PASSWORD = process.env.PASSWORD;
const OUTPUT_FILE = "./out/uploadOutput.json";
let RETRIES = 0;

if (FILE_URLS.length === 0) {
  console.error("at least one url required");
  return;
}

const httpOption = (USER && PASSWORD && { auth: `${USER}:${PASSWORD}` }) || {};

const writeOutput = (data) => {
  return new Promise((resolve, reject) => {
    fs.writeFile(OUTPUT_FILE, JSON.stringify(data), (err) => {
      if (err) return reject(err);
      resolve();
    });
  });
};

// Recursively attempt to upload the file to GCS. This function allows multiple tries in the event that the authentication is rejected.
const fetchAndStream = (url, resolve, reject) => {
  const protocol = new URL(url).protocol;
  const filename = path.basename(url);
  fetch[protocol].get(url, httpOption, async (resp) => {
    const file = bucket.file(filename);
    const writeStream = file.createWriteStream();
    if (resp.statusCode === 200)
      resp
      .pipe(writeStream)
      .on("finish", () => {
        resolve({ bucketName: BUCKET_NAME, objectName: filename });
      })
      .on("error", (err) => reject(err));
    else if (resp.statusCode !== 200 && RETRIES < 20) {
      console.log(`Upload failed with status ${resp.statusCode}. Retrying...${RETRIES + 1} / 20`)
      await new Promise(r => setTimeout(r, 2000));
      RETRIES++;
      fetchAndStream(url, resolve, reject);
    }
    else
      reject('Maximum numer of retries reached');
  });
};

const streamFileToBucket = (url) => {
  console.log(`uploading ${url}`);
  return new Promise((resolve, reject) => {
    fetchAndStream(url, resolve, reject);
  });
};

(async () => {
  try {
    const [files] = await bucket.getFiles();

    console.log(`received ${FILE_URLS.length} urls to upload.`);
    const skippedUrls = FILE_URLS.filter((url) =>
      files.some((f) => f.name === path.basename(url))
    );
    for (const url of skippedUrls) {
      console.log(`skipping ${url}`);
    }
    const urlsToUpload = FILE_URLS.filter(
      (url) => !files.some((f) => f.name === path.basename(url))
    );
    // We use asyncForEach instead of Promise.all to avoid overloading the GCS and ECCC servers
    // Ideally we'd have a queue system that limits the number of simultaneous uploads
    const uploadedObjects = await asyncMap(urlsToUpload, async (url) =>
      streamFileToBucket(url)
    );
    await writeOutput({ uploadedObjects, skippedUrls });
  } catch (err) {
    console.error(err);
  }
})();

async function asyncMap(array, callback) {
  const result = [];
  for (let index = 0; index < array.length; index++) {
    result.push(await callback(array[index], index, array));
  }
  return result;
}
