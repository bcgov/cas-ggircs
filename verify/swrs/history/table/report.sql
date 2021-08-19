-- Verify ggircs:swrs/history/table/report on pg

begin;

select pg_catalog.has_table_privilege('swrs_history.report', 'select');

rollback;
