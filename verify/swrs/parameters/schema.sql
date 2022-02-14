-- Verify ggircs:swrs/parameters/schema on pg

begin;

select pg_catalog.has_schema_privilege('swrs', 'usage');

rollback;
