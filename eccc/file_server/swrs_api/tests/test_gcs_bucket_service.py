from swrs_api.gcs_bucket_service import GcsBucketService
import unittest.mock as mock
import pytest

from swrs_api.tests.helpers import MockBlob

test_bucket_name = "test-bucket"

@pytest.fixture
def service_under_test():
  return GcsBucketService(test_bucket_name)

@mock.patch('google.cloud.storage.Client')
def test_list_zip_blobs(mock_gcs_client, service_under_test):
  fake_storage_content = [
                          MockBlob('file1.zip'), 
                          MockBlob('file2.nope'), 
                          MockBlob('file3.zip'), 
                          MockBlob('garbage'), 
                          MockBlob('13-*45]045*@@')
                        ]

  mock_gcs_instance = mock_gcs_client.return_value
  mock_gcs_instance.list_blobs.return_value = fake_storage_content

  assert service_under_test.list_zip_blobs() == [fake_storage_content[0], fake_storage_content[2]]

@pytest.mark.parametrize("input, expected",
  [
    ('name1', "gs://test-bucket/name1"),
    ('something.zip', "gs://test-bucket/something.zip"),
  ]
)
def test_file_url(input, expected, service_under_test):
  assert service_under_test.get_file_url(input) == expected
