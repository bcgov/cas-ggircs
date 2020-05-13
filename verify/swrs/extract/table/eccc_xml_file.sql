-- Verify swrs_transform:table_eccc_xml_file on pg

begin;

select pg_catalog.has_table_privilege('swrs_extract.eccc_xml_file', 'select');

rollback;
