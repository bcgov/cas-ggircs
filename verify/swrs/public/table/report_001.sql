-- Verify ggircs:swrs/public/table/report_001 on pg

begin;

select pg_catalog.has_table_privilege('swrs.report', 'select');

rollback;
