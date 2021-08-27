"""
This script lists the zip files contained in the swrs_extract.eccc_zip_file table, and,
for each record where xml_files_extracted is false, lists the xml files contained in the zip file and
inserts their contents in the swrs_extract.eccc_xml_file table.
"""

from zip_file_processor import process_report_xmls
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
    pg_conn = pg_pool.getconn()
    pg_cursor = pg_conn.cursor()
    pg_cursor.execute("select id, zip_file_name from swrs_extract.eccc_zip_file where xml_files_extracted = false;")
    zip_files = pg_cursor.fetchall()

    # get the list of objects in the bucket
    for file in zip_files:
        print(file)
        process_report_xmls(file[0], file[1], storage_client, gcs_bucket_name, pg_pool, log)

except (Exception, psycopg2.DatabaseError) as error:
    log.error(f"Error: {error}")
    sys.exit(1)
finally:
    pg_pool.closeall()
