-- Verify ggircs:swrs/utility/table/carbon_tax_act_fuel_type on pg

begin;

select pg_catalog.has_table_privilege('swrs_utility.carbon_tax_act_fuel_type', 'select');

rollback;
