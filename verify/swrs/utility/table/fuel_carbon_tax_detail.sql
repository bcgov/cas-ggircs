-- Verify ggircs:swrs/utility/table/fuel_carbon_tax_detail on pg

begin;

select pg_catalog.has_table_privilege('swrs_utility.fuel_carbon_tax_detail', 'select');

rollback;
