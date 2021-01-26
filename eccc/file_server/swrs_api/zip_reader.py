import os
import json
import zipfile
import logging
from dotenv import load_dotenv

load_dotenv()
log = logging.getLogger("ZipReader")

class ZipReader:

  # zipfile.read expects the password to be in bytes
  def passwd_to_bytes(pwd):
    return pwd.encode('utf-8')

  zip_passwords = [None] + list(map(passwd_to_bytes, json.loads(os.getenv('ECCC_ZIP_PASSWORDS'))))

  def list_file_contents(zip_file_descriptor):
    with zipfile.ZipFile(zip_file_descriptor) as unzipped:
      content_list = unzipped.namelist()
      return  content_list

  def extract_file_content(zip_file_descriptor, path):
    with zipfile.ZipFile(zip_file_descriptor) as unzipped:
      bytes = ZipReader.read_path_in_file(unzipped, path)
      return bytes

  # tries to open the file without password and then iterates through the list of passwords
  def read_path_in_file(zip: zipfile.ZipFile, path: str) -> bytes:
    for passwd in ZipReader.zip_passwords:
      try:
        file = zip.read(path,pwd=passwd)
        return file
      except Exception as inst:
        log.info("trying next password")
      
      return None