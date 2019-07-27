-- Verify ggircs:swrs/public/schema on pg

BEGIN;

select pg_catalog.has_schema_privilege('swrs', 'usage');

ROLLBACK;
