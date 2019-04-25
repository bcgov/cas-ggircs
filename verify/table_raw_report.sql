-- Verify ggircs:table_raw_report on pg

BEGIN;

select pg_catalog.has_table_privilege('ggircs_swrs.raw_report', 'select');

ROLLBACK;
