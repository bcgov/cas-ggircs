-- Verify ggircs:swrs/extract/table/eccc_attachment on pg

begin;

select pg_catalog.has_table_privilege('swrs_extract.eccc_attachment', 'select');

rollback;
