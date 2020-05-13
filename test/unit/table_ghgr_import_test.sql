set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(12);

-- Test table eccc_xml_file exists in schema swrs_extract
select has_table('swrs_extract', 'eccc_xml_file', 'Table eccc_xml_file exists');

-- Test column names in table eccc_xml_file are correct
select has_column('swrs_extract', 'eccc_xml_file', 'id', 'Table has column: id');
select has_column('swrs_extract', 'eccc_xml_file', 'xml_file', 'Table has column: xml_file');
select has_column('swrs_extract', 'eccc_xml_file', 'imported_at', 'Table has column: imported_at');

-- Test column id is the Primary Key
select col_is_pk('swrs_extract', 'eccc_xml_file', 'id', 'Column id is Primary Key');

-- Test columns have correct types
select col_type_is('swrs_extract', 'eccc_xml_file', 'id', 'integer', 'Column id has type integer');
select col_type_is('swrs_extract', 'eccc_xml_file', 'xml_file', 'xml', 'Column xml_file has type xml');
select col_type_is('swrs_extract', 'eccc_xml_file', 'imported_at', 'timestamp with time zone', 'Column imported_at has type timestamp with timezone');

-- Test NOT NULL columns have constraint
select col_not_null('swrs_extract', 'eccc_xml_file', 'xml_file', 'Column xml_file has NOT NULL constraint');
select col_not_null('swrs_extract', 'eccc_xml_file', 'imported_at', 'Column imported_at has NOT NULL constraint');

-- Test default columns have default
select col_has_default('swrs_extract', 'eccc_xml_file', 'imported_at', 'Column imported_at has default');

-- Test default columns have correct default value
select col_default_is('swrs_extract', 'eccc_xml_file', 'imported_at', 'now()', 'Column imported_at defaults to now()');

select finish();
rollback;
