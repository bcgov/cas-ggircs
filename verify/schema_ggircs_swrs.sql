-- Verify ggircs:schema_ggircs_swrs on pg

begin;

select pg_catalog.has_schema_privilege('ggircs_swrs', 'usage');

rollback;
