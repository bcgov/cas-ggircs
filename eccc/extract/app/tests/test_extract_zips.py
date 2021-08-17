
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
    zip_file_processor.process_zip_file_contents = Mock()

    test_file = Mock()
    test_file.name = 'GHGBC_PROD_test_file_name.zip'

    test_file.md5_hash = 'MWI1M2Q3ZjM4YjNkMzAzMTRjNDM2NmI3NmQwZWRkY2IgIHJlcXVpcmVtZW50cy50eHQK'  # pragma: allowlist secret

    mock_pg_cursor = Mock()

    mock_conection_attrs = {'cursor.return_value': mock_pg_cursor}
    mock_pg_connection = Mock(**mock_conection_attrs)

    mock_pool_attrs = {'getconn.return_value': mock_pg_connection}
    mock_pg_pool = Mock(**mock_pool_attrs)

    zip_file_processor.process_zip_file(None, test_file, mock_pg_pool, Mock())

    assert mock_pg_cursor.execute.call_count == 1
    mock_pg_cursor.execute.assert_called_once_with("insert xxx into yyy")


def test_process_zip_file_writes_xml_file_in_xml_table():
    pass


def test_process_zip_file_writes_non_xml_file_in_attachments_table():
    pass
