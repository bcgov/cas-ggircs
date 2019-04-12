-- Verify ggircs:schema_ggircs on pg

begin;

select pg_catalog.has_schema_privilege('ggircs', 'usage');

rollback;
