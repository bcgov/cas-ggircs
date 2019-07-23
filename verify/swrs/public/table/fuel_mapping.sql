-- Verify ggircs:table_fuel_mapping on pg

begin;

select pg_catalog.has_table_privilege('swrs.fuel_mapping', 'select');

rollback;
