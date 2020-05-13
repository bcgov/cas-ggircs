-- Verify swrs_transform:table_eccc_zip_file on pg

begin;

select pg_catalog.has_table_privilege('swrs_extract.eccc_zip_file', 'select');

rollback;
