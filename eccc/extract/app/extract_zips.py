"""
This script list the zip files in the GCS bucket (BUCKET_NAME env variable) and inserts records in the database
for any new zip files.
"""

from zip_file_processor import process_zip_file
import os
import sys
import logging
import psycopg2
from google.cloud import storage
from psycopg2 import pool


logging.basicConfig(
    format='%(asctime)s | %(name)s | %(levelname)s: %(message)s')
log = logging.getLogger('extract_zips')
log.setLevel(os.getenv("LOGLEVEL", "INFO"))

storage_client = storage.Client()
gcs_bucket_name = os.getenv('BUCKET_NAME')

try:
    # with an empty dsn, the postgres env vars are used
    pg_pool = pool.SimpleConnectionPool(1, 10, dsn='')

    # get the list of objects in the bucket
    for file in storage_client.list_blobs(gcs_bucket_name):
        process_zip_file(gcs_bucket_name, file, pg_pool, log)

except (Exception, psycopg2.DatabaseError) as error:
    log.error(f"Error: {error}")
    sys.exit(1)
finally:
    pg_pool.closeall()
