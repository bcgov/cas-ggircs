-- Verify ggircs:private/schema on pg

begin;

select pg_catalog.has_schema_privilege('swrs_private', 'usage');

rollback;
