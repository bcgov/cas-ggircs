import os
import sys
import json
import logging
import psycopg2
from smart_open import open
from google.auth.credentials import Credentials
from google.cloud import storage
from psycopg2 import pool


logging.basicConfig(
    format='%(asctime)s | %(name)s | %(levelname)s: %(message)s')
log = logging.getLogger('extract_zips')
log.setLevel(os.getenv("LOGLEVEL", "INFO"))

storage_client = storage.Client()

incremental_extract = True if os.getenv(
    'INCREMENTAL_EXTRACT', 'false') == 'true' else False
gcs_bucket_name = os.getenv('BUCKET_NAME')
with open("./out/uploadOutput.json") as f:
    eccc_upload_out = json.load(f)
uploaded_objects = eccc_upload_out.get('uploadedObjects')

try:
    # with an empty dsn, the postgres env vars are used
    pg_pool = pool.SimpleConnectionPool(1, 10, dsn='')
    if incremental_extract:
        if uploaded_objects is not None:
            for uploaded_obj in uploaded_objects:
                bucket = storage_client.get_bucket(
                    uploaded_obj.get('bucketName'))
                file = bucket.get_blob(uploaded_obj.get('objectName'))
                process_zip_file(bucket.name, file, storage_client, pg_pool)
    else:
        for file in storage_client.list_blobs(gcs_bucket_name):
            process_zip_file(gcs_bucket_name, file, storage_client, pg_pool)


except (Exception, psycopg2.DatabaseError) as error:
    log.error(f"Error: {error}")
    sys.exit(1)
finally:
    pg_pool.closeall()
