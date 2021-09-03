import base64
import psycopg2
import zipfile
import hashlib
import chardet
import json
import os
import re
import time
from google.cloud import storage
from smart_open import open
from multiprocessing import Pool

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


def process_xml_file(zip_file_id, zip_file_path, zip_file_name, file_path, log):
    insert_sql = """
        insert into swrs_extract.eccc_xml_file(xml_file, xml_file_name, xml_file_md5_hash, zip_file_id)
        values (%s, %s, %s, %s)
        on conflict(xml_file_md5_hash) do nothing
    """
    log.info(f"Processing {file_path} in zip file {zip_file_name}")
    return_code = 0
    with psycopg2.connect(dsn='') as pg_connection:
        try:
            storage_client = storage.Client()
            with open(zip_file_path, 'rb', transport_params=dict(client=storage_client)) as fin:
                with zipfile.ZipFile(fin) as finz:
                    file_bytes = read_file(finz, file_path, log)
                    if file_bytes is None:
                        log.error(
                            f"error: failed to read {file_path} in zip file {zip_file_name}")
                        return

                    file_md5_hash = hashlib.md5(file_bytes).hexdigest()
                    if file_md5_hash in quarantined_files_md5_hash:
                        log.warn(f"skipping {file_path} as it is quarantined")
                        return

                    encoding = chardet.detect(file_bytes)['encoding']
                    xml_string = file_bytes.decode(encoding)
                    log.debug(xml_string)

                    with pg_connection.cursor() as pg_cursor:
                        pg_cursor.execute(insert_sql,(xml_string.replace('\0', ''),file_path,file_md5_hash,zip_file_id))
                    pg_connection.commit()
        except (Exception, psycopg2.DatabaseError) as error:
            log.error(f"Error while processing {file_path} in zip file {zip_file_name}: {error}")
            return_code = 1
            pg_connection.rollback()

    return return_code

def process_report_xmls(zip_file_id, zip_file_name, storage_client, bucket_name, pg_pool, log):
    zip_file_path = f"gs://{bucket_name}/{zip_file_name}"

    extract_error_count = 0
    def save_result(res):
        nonlocal extract_error_count
        extract_error_count += res
    start = time.time()
    with Pool(processes=32) as pool:
        with open(zip_file_path, 'rb', transport_params=dict(client=storage_client)) as fin:
            with zipfile.ZipFile(fin) as finz:
                for file_path in finz.namelist():
                    if file_path.endswith('.xml'):
                        pool.apply_async(process_xml_file, (zip_file_id, zip_file_path, zip_file_name, file_path, log), callback=save_result)
        pool.close()
        pool.join()
    end = time.time()
    log.info(f"Processed {zip_file_name} in {end - start} seconds")
    with pg_pool.getconn() as pg_connection:
        with pg_connection.cursor() as pg_cursor:
            pg_cursor.execute(
                "update swrs_extract.eccc_zip_file set xml_files_extracted = true, xml_files_extract_error_count = %s where id = %s;",
                (extract_error_count, zip_file_id)
            )
            pg_connection.commit()
            pg_pool.putconn(pg_connection)


def process_report_attachments(zip_file_id, zip_file_name, storage_client, bucket_name, pg_pool, log):
    insert_sql = """
        insert into swrs_extract.eccc_attachment(
            attachment_file_path, attachment_file_md5_hash, zip_file_id,
            swrs_report_id, source_type_id, attachment_uploaded_file_name
        )
        values (%s, %s, %s, %s, %s, %s)
        on conflict(attachment_file_path, zip_file_id) do nothing;"""
    zip_file_path = f"gs://{bucket_name}/{zip_file_name}"
    extract_error_count = 0
    with open(zip_file_path, 'rb', transport_params=dict(client=storage_client)) as fin:
        with zipfile.ZipFile(fin) as finz:
            for file_path in finz.namelist():
                with pg_pool.getconn() as pg_connection:
                    try:
                        if not file_path.endswith('.xml') and not file_path.endswith('.zip') and not file_path.endswith('/'):
                            log.info(f"Processing {file_path} in zip file {zip_file_name}")

                            file_bytes = read_file(finz, file_path, log)
                            if file_bytes is None:
                                log.error(
                                    f"error: failed to read {file_path} in zip file {zip_file_name}")
                                continue

                            file_md5_hash = hashlib.md5(file_bytes).hexdigest()
                            match = re.search(r'^.*/Report_(\d+).*_SourceTypeId_(\d+)_(.*)$', file_path)
                            swrs_report_id = match.group(1) if match is not None else None
                            source_type_id = match.group(2) if match is not None else None
                            attachment_uploaded_file_name = match.group(3) if match is not None else None

                            with pg_connection.cursor() as pg_cursor:
                                pg_cursor.execute(insert_sql,(file_path, file_md5_hash, zip_file_id, swrs_report_id, source_type_id, attachment_uploaded_file_name))
                        pg_connection.commit()
                    except (Exception, psycopg2.DatabaseError) as error:
                        log.error(f"Error while processing {file_path} in zip file {zip_file_name}: {error}")
                        extract_error_count += 1
                        pg_connection.rollback()
                    finally:
                        pg_pool.putconn(pg_connection)

    with pg_pool.getconn() as pg_connection:
        with pg_connection.cursor() as pg_cursor:
            pg_cursor.execute(
                "update swrs_extract.eccc_zip_file set attachments_extracted = true, attachments_extract_error_count = %s where id = %s;",
                (extract_error_count, zip_file_id)
            )
            pg_connection.commit()
            pg_pool.putconn(pg_connection)


def process_zip_file(bucket_name, file, pg_pool, log):
    if not file.name.endswith('.zip'):
        log.info(
            f"{file.name} was uploaded in the bucket {bucket_name}, but that doesn't look like a zip file. Skipping.")
        return
    if not file.name.startswith('GHGBC_PROD_'):
        log.info(
            f"{file.name} was uploaded in the bucket {bucket_name}, but that doesn't look like a production report. Skipping.")
        return
    file_path = f"gs://{bucket_name}/{file.name}"
    log.info(f"Processing {file_path}")
    zipfile_md5 = base64.b64decode(file.md5_hash).hex(
    ) if file.md5_hash is not None else None
    try:
        pg_connection = pg_pool.getconn()
        pg_cursor = pg_connection.cursor()
        pg_cursor.execute(
            """insert into swrs_extract.eccc_zip_file(zip_file_name, zip_file_md5_hash)
      values (%s, %s)
      on conflict(zip_file_md5_hash) do nothing
      returning id""",
            (file.name, zipfile_md5)
        )
        record = pg_cursor.fetchone()
        zipfile_id = record[0] if record is not None else None;
        if zipfile_id is not None:
            log.info(f"New zip file id: {zipfile_id}.")
        else:
            log.info(f"zip file with md5 hash {zipfile_md5} already exists, skipping...")
        pg_connection.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        log.error(f"Error while processing {file_path}: {error}")
        pg_connection.rollback()
    finally:
        pg_cursor.close()
        pg_pool.putconn(pg_connection)
