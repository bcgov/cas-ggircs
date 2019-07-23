-- Verify ggircs:table_report on pg

begin;

select pg_catalog.has_table_privilege('swrs.report', 'select');

rollback;
