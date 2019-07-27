-- Verify ggircs:swrs/extract/schema on pg

BEGIN;

select pg_catalog.has_schema_privilege('swrs_extract', 'usage');

ROLLBACK;
