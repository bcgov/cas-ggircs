-- Verify ggircs:table_report on pg

begin;

select pg_catalog.has_table_privilege('ggircs_swrs_load.report', 'select');

rollback;
