-- Verify ggircs:swrs/history/table/report on pg

BEGIN;

select pg_catalog.has_table_privilege('swrs_history.report', 'select');

ROLLBACK;
