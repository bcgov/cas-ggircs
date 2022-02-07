-- Verify ggircs:swrs/public/table/fuel_carbon_tax_details_002 on pg

begin;

select pg_catalog.has_table_privilege('swrs.fuel_carbon_tax_details', 'select');

rollback;
