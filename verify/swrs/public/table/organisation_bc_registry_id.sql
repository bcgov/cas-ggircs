-- Verify ggircs:swrs/public/table/organisation_bc_registry_id on pg

begin;

select pg_catalog.has_table_privilege('swrs.organisation_bc_registry_id', 'select');

rollback;
