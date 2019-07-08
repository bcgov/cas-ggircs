-- Verify ggircs:ciip_table_production on pg

begin;

select pg_catalog.has_table_privilege('ciip.production', 'select');

rollback;
