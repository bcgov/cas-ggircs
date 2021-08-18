import base64
import psycopg2
import zipfile
import hashlib
import chardet
import json
import os
from smart_open import open

quarantined_files_md5_hash = [
    'd9fa31d1c971fe7573e808252713254c']  # pragma: allowlist secret


# zipfile.read expects the password to be in bytes
def passwd_to_byte(pwd):
    return pwd.encode('utf-8')


zip_passwords = [
    None] + list(map(passwd_to_byte, json.loads(os.getenv('ECCC_ZIP_PASSWORDS'))))

# tries to open the file without password and then iterates through the list of passwords


def read_file(fin, path, log):
    for passwd in zip_passwords:
        try:
            file = fin.read(path, pwd=passwd)
            # the current password was the correct one, put it at the beginning of the list
            zip_passwords.remove(passwd)
            zip_passwords.insert(0, passwd)
            return file
        except Exception as inst:
            log.info("trying next password")

# Params:
#   file_path: path inside the zip file
#   file_name: zip file name
def process_report_xml(zip_file_path, zip_file_name, zipfile_id, storage_client, pg_pool, log):
    insert_sql = """insert into swrs_extract.eccc_xml_file(xml_file, xml_file_name, xml_file_md5_hash, zip_file_id) values (%s, %s, %s, %s) on conflict(xml_file_md5_hash) do update set xml_file=excluded.xml_file, xml_file_name=excluded.xml_file_name, zip_file_id=excluded.zip_file_id"""
    with open(zip_file_path, 'rb', transport_params=dict(client=storage_client)) as fin:
        with zipfile.ZipFile(fin) as finz:
            for file_path in finz.namelist():
                try: 
                    pg_connection = pg_pool.getconn()
                    pg_cursor = pg_connection.cursor()
                    if file_path.endswith('.xml'):
                        log.info(f"Processing {file_path}")
                        file_bytes = read_file(finz, file_path, log)
                        if file_bytes is None:
                            log.error(
                                f"error: failed to read {file_path} in zip file {zip_file_name}")
                            continue

                        file_md5_hash = hashlib.md5(file_bytes).hexdigest()
                        if file_md5_hash in quarantined_files_md5_hash:
                            log.warn(f"skipping {file_path} as it is quarantined")
                            continue

                        encoding = chardet.detect(file_bytes)['encoding']
                        xml_string = file_bytes.decode(encoding)
                        log.debug(xml_string)

                        pg_cursor.execute(insert_sql,(xml_string.replace('\0', ''),file_path,file_md5_hash,zipfile_id))
                    pg_connection.commit()
                except (Exception, psycopg2.DatabaseError) as error:
                    log.error(f"Error while processing {file_path} in zip file {zip_file_name}: {error}")
                    pg_connection.rollback()
                finally:
                    pg_cursor.close()
                    pg_pool.putconn(pg_connection)

# Params:
#   file_path: path inside the zip file
#   file_name: zip file name
def process_report_attachments(zip_file_path, zip_file_name, zipfile_id, storage_client, pg_pool, log):
    insert_sql = """insert into swrs_extract.eccc_attachments(attachment_file_name, attachment_file_md5_hash, zip_file_id) values (%s, %s, %s) on conflict on constraint attachment_md5_zip_filename_uindex do nothing"""
    with open(zip_file_path, 'rb', transport_params=dict(client=storage_client)) as fin:
        with zipfile.ZipFile(fin) as finz:
            for file_path in finz.namelist():
                try: 
                    pg_connection = pg_pool.getconn()
                    pg_cursor = pg_connection.cursor()
                    if not file_path.endswith('.xml') and not file_path.endswith('.zip'):
                        log.info(f"Processing {file_path} in zip file {zip_file_name}")

                        file_bytes = read_file(finz, file_path, log)
                        if file_bytes is None:
                            log.error(
                                f"error: failed to read {file_path} in zip file {zip_file_name}")
                            continue

                        file_md5_hash = hashlib.md5(file_bytes).hexdigest()
                        pg_cursor.execute(insert_sql,(file_path, file_md5_hash, zipfile_id))
                    pg_connection.commit()
                except (Exception, psycopg2.DatabaseError) as error:
                    log.error(f"Error while processing {file_path} in zip file {zip_file_name}: {error}")
                    pg_connection.rollback()
                finally:
                    pg_cursor.close()
                    pg_pool.putconn(pg_connection)



def process_zip_file(bucket_name, file, pg_pool, log):
    if not file.name.endswith('.zip'):
        log.debug(
            f"{file.name} was uploaded in the bucket {bucket_name}, but that doesn't look like a zip file. Skipping.")
        return
    if not file.name.startswith('GHGBC_PROD_'):
        log.debug(
            f"{file.name} was uploaded in the bucket {bucket_name}, but that doesn't look like a production report. Skipping.")
        return
    file_path = f"gs://{bucket_name}/{file.name}"
    zipfile_md5 = base64.b64decode(file.md5_hash).hex(
    ) if file.md5_hash is not None else None
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
