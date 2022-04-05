-- Verify ggircs:swrs/parameters/table/carbon_tax_act_fuel_type_001 on pg

begin;

select pg_catalog.has_table_privilege('ggircs_parameters.carbon_tax_act_fuel_type', 'select');

rollback;
