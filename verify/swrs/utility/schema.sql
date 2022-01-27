-- Verify ggircs:swrs/utility/schema on pg

BEGIN;

select pg_catalog.has_schema_privilege('swrs', 'usage');

ROLLBACK;
