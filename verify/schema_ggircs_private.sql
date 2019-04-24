-- Verify ggircs:schema_ggircs_private on pg

begin;

select pg_catalog.has_schema_privilege('ggircs_private', 'usage');

rollback;
