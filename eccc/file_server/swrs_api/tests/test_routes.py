from flask.testing import FlaskClient
import pytest
from swrs_api import app as app
from unittest.mock import patch
import json

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


class MockBlob:
  name = "a"
  size = 1024*1024 # 1MB
  time_created = "Thu, 21 Jan 1999 00:00:00 GMT"