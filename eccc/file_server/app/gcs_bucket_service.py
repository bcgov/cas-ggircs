###
# Service providing exploration of GCS buckets containting zip files
###

from google.cloud import storage

class GcsBucketService:

  bucket_name = ''
  bucket_prefix = ''

  def __init__(self, bucket_name, bucket_prefix=''):
    self.bucket_name = bucket_name
    self.bucket_prefix = bucket_prefix

  def list_zip_blobs(self):
    storage_client = storage.Client()

    blobs = storage_client.list_blobs(self.bucket_name, prefix=self.bucket_prefix)
    zip_blobs = [blob for blob in blobs if blob.name.endswith('.zip')]

    return zip_blobs

    file_objects = [GcsBucketService.build_file_object(blob) for blob in zip_blobs]
    return file_objects

  def get_file_url(self, blob_name):
    return f"gs://{self.bucket_name}/{blob_name}"

  
