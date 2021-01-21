from flask.testing import FlaskClient
import pytest

from app import app
from app.gcs_bucket_service import GcsBucketService

import unittest.mock as mock
import datetime

@pytest.fixture
def client():
  app.app.config['TESTING'] = True

  with app.app.test_client() as client:
    yield client


def test_root_url(client):
  response = client.get('/')
  assert b'GIIRCS internal API server' in response.data


def test_files_list_url(client):
  with mock.patch('app.gcs_bucket_service.GcsBucketService') as MockedService:
    instance = MockedService.return_value
    instance.list_zip_files.return_value = []

    response = client.get('/files')

    assert b'[]' in response.data


class MockBlob:
  name = "a"
  size = 1
  time_created = datetime.date.today()