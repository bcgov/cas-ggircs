-- Verify ggircs:ciip_table_production on pg

begin;

select pg_catalog.has_table_privilege('ciip_2018.production', 'select');

rollback;
