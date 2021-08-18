from unittest.mock import MagicMock, Mock, patch

import os
os.environ['ECCC_ZIP_PASSWORDS'] = '["ABCD"]'

import zip_file_processor
# Test that process_zip_file
# - opens a zip file and creates a record in swrs_extract.eccc_zip_file
# - for each file in this zip file:
#    - if the file is xml => new record in swrs_extract.eccc_xml_file
#    - otherwise => new record in swrs_extract.eccc_attachments


def test_process_zip_file_opens_zip_and_creates_zip_record():
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


def test_process_zip_file_writes_xml_file_in_xml_table():
    mock_storage_client = Mock()

    mock_cursor_attrs = {'fetchone.return_value': ['first_test_id']}
    mock_pg_cursor = Mock(**mock_cursor_attrs)

    mock_conection_attrs = {'cursor.return_value': mock_pg_cursor}
    mock_pg_connection = Mock(**mock_conection_attrs)

    mock_pool_attrs = {'getconn.return_value': mock_pg_connection}
    mock_pg_pool = Mock(**mock_pool_attrs)

    mock_log = Mock()

    file_path = os.path.dirname(__file__) + '/fixtures/Archive.zip'

    zip_file_processor.process_report_xml(file_path, 'Archive.zip', '77000', mock_storage_client, mock_pg_pool, mock_log)

    assert mock_pg_cursor.execute.call_count == 1
    mock_pg_cursor.execute.assert_called_once_with(
        '''insert into swrs_extract.eccc_xml_file(xml_file, xml_file_name, xml_file_md5_hash, zip_file_id) values (%s, %s, %s, %s) on conflict(xml_file_md5_hash) do update set xml_file=excluded.xml_file, xml_file_name=excluded.xml_file_name, zip_file_id=excluded.zip_file_id''',
        ('<Data>TEST</Data>\n', 'test.xml', '2a75b028ccddefb4398933ff376bdcb3', '77000')
    )


def test_process_zip_file_writes_non_xml_file_in_attachments_table():
    mock_storage_client = Mock()

    mock_cursor_attrs = {'fetchone.return_value': ['first_test_id']}
    mock_pg_cursor = Mock(**mock_cursor_attrs)

    mock_conection_attrs = {'cursor.return_value': mock_pg_cursor}
    mock_pg_connection = Mock(**mock_conection_attrs)

    mock_pool_attrs = {'getconn.return_value': mock_pg_connection}
    mock_pg_pool = Mock(**mock_pool_attrs)

    mock_log = Mock()

    file_path = os.path.dirname(__file__) + '/fixtures/Archive.zip'

    zip_file_processor.process_report_attachments(file_path, 'Archive.zip', '77000', mock_storage_client, mock_pg_pool, mock_log)

    assert mock_pg_cursor.execute.call_count == 1
    mock_pg_cursor.execute.assert_called_once_with(
        '''insert into swrs_extract.eccc_attachments(attachment_file_name, attachment_file_md5_hash, zip_file_id) values (%s, %s, %s) on conflict on constraint attachment_md5_zip_filename_uindex do nothing''',
        ('test_pdf.pdf', 'c9cc1d69eab81593c9f2214ce54d31e9', '77000')
    )
