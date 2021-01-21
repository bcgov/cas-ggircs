from flask.testing import FlaskClient
import pytest

from app import app
from app.gcs_bucket_service import GcsBucketService

import unittest.mock as mock
from unittest.mock import MagicMock
import datetime

@pytest.fixture
def client():
  app.app.config['TESTING'] = True

  with app.app.test_client() as client:
    yield client


def test_root_url(client):
  response = client.get('/')
  assert b'GIIRCS internal API server' in response.data


def list_zip_blobs_mocked(self):
    a = []
    blob = MockBlob()
    return [blob]

def test_files_list_url(client):
  # with mock.patch('app.gcs_bucket_service.GcsBucketService') as MockedService:
    # instance = MockedService.return_value
    # instance.list_zip_files.return_value = []
    GcsBucketService.list_zip_blobs = list_zip_blobs_mocked


    response = client.get('/files')
    print(response.data.decode('utf-8'))

    assert '"name":"a"' in response.data.decode('utf-8')
    assert '"created_at":"Thu, 21 Jan 1999 00:00:00 GMT"' in response.data.decode('utf-8')


class MockBlob:
  name = "a"
  size = 1
  time_created = "Thu, 21 Jan 1999 00:00:00 GMT" #datetime.date.today()
