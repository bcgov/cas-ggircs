const { Storage } = require("@google-cloud/storage");
const argv = require("yargs").argv;

const storage = new Storage();

const BUCKET_NAME = argv.bucket;
const bucket = storage.bucket(BUCKET_NAME);
(async () => {
  await bucket.deleteFiles();
  await bucket.delete();
})();
