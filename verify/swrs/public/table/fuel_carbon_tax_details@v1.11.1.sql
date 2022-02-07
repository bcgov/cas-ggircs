-- Verify ggircs:table_fuel_carbon_tax_details on pg

begin;

select pg_catalog.has_table_privilege('swrs.fuel_carbon_tax_details', 'select');

rollback;
