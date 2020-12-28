const { Storage } = require("@google-cloud/storage");
const argv = require("yargs").argv;

const storage = new Storage();

const BUCKET_NAME = argv.bucket;
(async () => {
  const [buckets] = await storage.getBuckets();
  const bucket = buckets.find((b) => b.name === BUCKET_NAME);
  if (bucket) {
    await bucket.deleteFiles();
    await bucket.delete();
  }
  await storage.createBucket(BUCKET_NAME);
})();
