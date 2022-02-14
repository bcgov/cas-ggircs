-- Verify ggircs:swrs/parameters/table/fuel_carbon_tax_detail on pg

begin;

select pg_catalog.has_table_privilege('ggircs_parameters.fuel_carbon_tax_detail', 'select');

rollback;
