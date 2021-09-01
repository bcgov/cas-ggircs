-- Verify ggircs:swrs/extract/table/eccc_zip_file_001.sql on pg

begin;

select pg_catalog.has_table_privilege('swrs_extract.eccc_zip_file', 'select');

rollback;
