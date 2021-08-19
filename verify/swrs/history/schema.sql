-- Verify ggircs:swrs/history/schema on pg

BEGIN;

select pg_catalog.has_schema_privilege('swrs_history', 'usage');

ROLLBACK;
