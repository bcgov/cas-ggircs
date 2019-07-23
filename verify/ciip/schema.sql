-- Verify ggircs:schema_ciip on pg

BEGIN;

select pg_catalog.has_schema_privilege('ciip_2018', 'usage');

ROLLBACK;
