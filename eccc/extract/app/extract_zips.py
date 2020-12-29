import os, sys, json, zipfile, chardet, logging, psycopg2, base64, hashlib
from smart_open import open
from google.auth.credentials import Credentials
from google.cloud import storage
from psycopg2 import pool

quarantined_files_md5_hash = ['d9fa31d1c971fe7573e808252713254c']

logging.basicConfig(format='%(asctime)s | %(name)s | %(levelname)s: %(message)s')
log = logging.getLogger('extract_zips')
log.setLevel(os.getenv("LOGLEVEL", "INFO"))

storage_client = storage.Client()

incremental_extract = True if os.getenv('INCREMENTAL_EXTRACT', 'false') == 'true' else False
gcs_bucket_name = os.getenv('BUCKET_NAME')
with open("./out/uploadOutput.json") as f:
  eccc_upload_out = json.load(f)
uploaded_objects = eccc_upload_out.get('uploadedObjects')

# zipfile.read expects the password to be in bytes
def passwd_to_byte(pwd):
  return pwd.encode('utf-8')
zip_passwords = [None] + list(map(passwd_to_byte, json.loads(os.getenv('ECCC_ZIP_PASSWORDS'))))

# tries to open the file without password and then iterates through the list of passwords
def read_xml_file(fin, path):
  for passwd in zip_passwords:
    try:
      file = fin.read(path,pwd=passwd)
      # the current password was the correct one, put it at the beginning of the list
      zip_passwords.remove(passwd)
      zip_passwords.insert(0, passwd)
      return file
    except Exception as inst:
      log.info("trying next password")

def process_zip_file(bucket_name, file, pg_pool):
  if not file.name.endswith('.zip'):
    log.debug(f"{file.name} was uploaded in the bucket {bucket_name}, but that doesn't look like a zip file. Skipping.")
    return
  file_path = f"gs://{bucket_name}/{file.name}"
  zipfile_md5 = base64.b64decode(file.md5_hash).hex() if file.md5_hash is not None else None
  try:
    pg_connection = pg_pool.getconn()
    pg_cursor = pg_connection.cursor()
    pg_cursor.execute(
      """insert into swrs_extract.eccc_zip_file(zip_file_name, zip_file_md5_hash)
      values (%s, %s)
      on conflict(zip_file_md5_hash) do update set zip_file_name=excluded.zip_file_name
      returning id""",
      (file.name, zipfile_md5)
    )
    zipfile_id = pg_cursor.fetchone()[0]
    log.info(f"zip id {zipfile_id}")
    log.info(f"Processing {file_path}")
    pg_connection.commit()
  except (Exception, psycopg2.DatabaseError) as error:
    log.error(f"Error while processing {file_path}: {error}")
    pg_connection.rollback()
  finally:
    pg_cursor.close()
    pg_pool.putconn(pg_connection)

  with open(file_path, 'rb', transport_params=dict(client=storage_client)) as fin:
    with zipfile.ZipFile(fin) as finz:
      for report_path in finz.namelist():
        if not report_path.endswith('.xml'):
          log.debug(f"skipping {report_path}")
          continue

        try:
          pg_connection = pg_pool.getconn()
          pg_cursor = pg_connection.cursor()
          log.info(f"Processing {report_path}")
          xml_bytes = read_xml_file(finz, report_path)
          if xml_bytes is None:
            log.error(f"error: failed to read {report_path} in zip file {file.name}")
            continue

          encoding = chardet.detect(xml_bytes)['encoding']
          xml_string = xml_bytes.decode(encoding)
          xml_file_md5_hash = hashlib.md5(xml_bytes).hexdigest()
          if xml_file_md5_hash in quarantined_files_md5_hash:
            log.warn(f"skipping {report_path} as it is quarantined")
            continue

          log.debug(xml_string)
          pg_cursor.execute("""
            insert into swrs_extract.eccc_xml_file(xml_file, xml_file_name, xml_file_md5_hash, zip_file_id)
            values (%s, %s, %s, %s)
            on conflict(xml_file_md5_hash) do update set
            xml_file=excluded.xml_file,
            xml_file_name=excluded.xml_file_name,
            zip_file_id=excluded.zip_file_id
            """,
            (
              xml_string.replace('\0', ''),
              report_path,
              xml_file_md5_hash,
              zipfile_id
            )
          )
          pg_connection.commit()
        except (Exception, psycopg2.DatabaseError) as error:
          log.error(f"Error while processing {report_path}: {error}")
          pg_connection.rollback()
        finally:
          pg_cursor.close()
          pg_pool.putconn(pg_connection)


    log.info(f"Finished processing {file_path}")


try:
  pg_pool = pool.SimpleConnectionPool(1, 10, dsn='') # with an empty dsn, the postgres env vars are used
  if incremental_extract:
    if uploaded_objects is not None:
      for uploaded_obj in uploaded_objects:
        bucket = storage_client.get_bucket(uploaded_obj.get('bucketName'))
        file = bucket.get_blob(uploaded_obj.get('objectName'))
        process_zip_file(bucket.name, file, pg_pool)
  else:
    for file in storage_client.list_blobs(gcs_bucket_name):
      process_zip_file(gcs_bucket_name, file, pg_pool)


except (Exception, psycopg2.DatabaseError) as error:
  log.error(f"Error: {error}")
  sys.exit(1)
finally:
  pg_pool.closeall()
