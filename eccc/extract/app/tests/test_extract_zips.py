
from unittest.mock import MagicMock, Mock
import unittest.mock as mock

import google.cloud.storage
google.cloud.storage.Client = Mock()

import os
os.getenv = Mock(return_value='["ABCD"]')

import smart_open
smart_open.open = MagicMock()

import zipfile
zipfile.ZipFile = Mock()

import zip_file_processor
# Test that process_zip_file
# - opens a zip file and creates a record in swrs_extract.eccc_zip_file
# - for each file in this zip file:
#    - if the file is xml => new record in swrs_extract.eccc_xml_file
#    - otherwise => new record in swrs_extract.eccc_attachments


@mock.patch('google.cloud.storage.Client')
def test_process_zip_file_opens_zip_and_creates_zip_record(mock_google_storage):
    mock_contents_function = zip_file_processor.process_zip_file_contents = Mock()

    test_file = Mock()
    test_file.name = 'GHGBC_PROD_test_file_name.zip'
    test_file.md5_hash = '0000'

    mock_cursor_attrs = {'fetchone.return_value': ['first_test_id']}
    mock_pg_cursor = Mock(**mock_cursor_attrs)

    mock_conection_attrs = {'cursor.return_value': mock_pg_cursor}
    mock_pg_connection = Mock(**mock_conection_attrs)

    mock_pool_attrs = {'getconn.return_value': mock_pg_connection}
    mock_pg_pool = Mock(**mock_pool_attrs)

    mock_log = Mock()

    zip_file_processor.process_zip_file(
        "bucket-name", test_file, mock_pg_pool, mock_log)

    assert mock_pg_cursor.execute.call_count == 1
    mock_pg_cursor.execute.assert_called_once_with(
        '''insert into swrs_extract.eccc_zip_file(zip_file_name, zip_file_md5_hash)
      values (%s, %s)
      on conflict(zip_file_md5_hash) do update set zip_file_name=excluded.zip_file_name
      returning id''',
        ('GHGBC_PROD_test_file_name.zip', 'd34d34')
    )
    mock_contents_function.assert_called_once_with(
        'gs://bucket-name/GHGBC_PROD_test_file_name.zip',
        test_file,
        'first_test_id',
        mock_google_storage(),
        mock_pg_pool,
        mock_log
    )


def test_process_zip_file_writes_xml_file_in_xml_table():
    pass


def test_process_zip_file_writes_non_xml_file_in_attachments_table():
    pass
