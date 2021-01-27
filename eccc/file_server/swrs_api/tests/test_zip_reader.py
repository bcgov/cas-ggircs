import pytest
import os

from swrs_api.zip_reader import ZipReader


def test_list_zip_content():
  
  expected = ["test.xml", "test_pdf.pdf"]

  with open(os.path.dirname(__file__) + '/fixtures/Archive.zip', 'rb') as file:
    assert expected == ZipReader.list_file_contents(file)

def test_read_path_with_password():
  with open(os.path.dirname(__file__) + '/fixtures/test.xml', 'rb') as expected_file:
    expected_bytes = expected_file.read()

  ZipReader.zip_passwords = [ZipReader.passwd_to_bytes('test')]

  with open(os.path.dirname(__file__) + '/fixtures/Archive_password_is_test.zip', 'rb') as zip_file:
    extracted_bytes = ZipReader.extract_file_content(zip_file, 'test.xml')

  assert  expected_bytes == extracted_bytes
