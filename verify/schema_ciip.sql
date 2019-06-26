-- Verify ggircs:schema_ciip on pg

BEGIN;

select pg_catalog.has_schema_privilege('ciip', 'usage');

ROLLBACK;
