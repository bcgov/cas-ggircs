-- Verify ggircs:swrs/extract/table/eccc_attachments on pg

begin;

select pg_catalog.has_table_privilege('swrs_extract.eccc_attachments', 'select');

rollback;
