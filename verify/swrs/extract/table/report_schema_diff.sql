-- Verify ggircs:table_report_schema_diff on pg

begin;

select pg_catalog.has_table_privilege('swrs_extract.report_schema_diff', 'select');

rollback;
