-- Verify ggircs:ciip_table_energy on pg

begin;

select pg_catalog.has_table_privilege('ciip_2018.energy', 'select');

rollback;

