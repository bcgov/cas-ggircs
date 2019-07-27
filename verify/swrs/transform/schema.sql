-- Verify ggircs:swrs/transform/schema on pg

BEGIN;

select pg_catalog.has_schema_privilege('swrs_transform', 'usage');

ROLLBACK;
