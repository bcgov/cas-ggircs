from flask.testing import FlaskClient
import pytest
from swrs_api import app as app
from unittest.mock import patch
import json
import os
from swrs_api.tests.helpers import MockBlob

@pytest.fixture
def client():
  app.app.config['TESTING'] = True

  with app.app.test_client() as client:
      yield client

def test_root_url(client):
  response = client.get('/')
  assert b'GIIRCS internal API server' in response.data

@patch('swrs_api.gcs_bucket_service.GcsBucketService')
def test_files_list_url(class_mock, client):
  instance = class_mock.return_value
  instance.list_zip_blobs.return_value = [MockBlob()]

  response = client.get('/files')
  response_string = response.data.decode('utf-8').strip()

  assert response_string == '[{"created_at":"Thu, 21 Jan 1999 00:00:00 GMT","name":"a","size":1.0}]'

@patch('swrs_api.gcs_bucket_service.GcsBucketService')
def test_file_list_content(class_mock, client):
  service_instance = class_mock.return_value
  service_instance.get_zip_blob.return_value = MockBlob(size=2*1024*1024)
  service_instance.get_file_url.return_value = os.path.dirname(__file__) + '/fixtures/Archive.zip'

  response = client.get('/files/Archive.zip')

  service_instance.get_zip_blob.assert_called_with('Archive.zip')
  service_instance.get_file_url.assert_called_with('Archive.zip')

  expected={
    "zip_content_list":["test.xml", "test_pdf.pdf"],
    "zip_file_content_count":2,
    "zip_file_name":"Archive.zip",
    "zip_file_size":2
    }

  assert json.loads(response.data) == expected

  pass

@patch('swrs_api.gcs_bucket_service.GcsBucketService')
def test_file_full_download(class_mock, client):

  service_instance = class_mock.return_value
  service_instance.get_zip_blob.return_value = MockBlob(size=2*1024*1024)
  service_instance.get_file_url.return_value = os.path.dirname(__file__) + '/fixtures/Archive.zip'

  response = client.get('/files/test.xml/download')
  assert 'test.xml' in str(response.headers)
  print(response.status)
  assert '200 OK' in str(response)
  pass

@patch('swrs_api.gcs_bucket_service.GcsBucketService')
def test_file_content_download_zip(class_mock,client):

  service_instance = class_mock.return_value
  service_instance.get_zip_blob.return_value = MockBlob(size=2*1024*1024)
  service_instance.get_file_url.return_value = os.path.dirname(__file__) + '/fixtures/Archive.zip'

  response = client.get('/files/Archive.zip/download')
  assert 'Archive.zip' in str(response.headers)
  print(response.status)
  assert '200 OK' in str(response)
  pass

# Note: this tests that the api responds to any file request with the mocked file
# The file content is not tested for
@patch('swrs_api.gcs_bucket_service.GcsBucketService')
def test_file_content_download_pdf(class_mock, client):
  service_instance = class_mock.return_value
  service_instance.get_zip_blob.return_value = MockBlob(size=2*1024*1024)
  service_instance.get_file_url.return_value = os.path.dirname(__file__) + '/fixtures/Archive.zip'

  response = client.get('/files/test_file.pdf/download')
  print(response)
  assert 'test_file.pdf' in str(response.headers)
  assert '200 OK' in str(response.status)
  pass
