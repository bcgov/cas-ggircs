begin;
select plan(8);

-- Test table exists in ggircs_parameters schema
select has_table(
    'ggircs_parameters', 'carbon_tax_act_fuel_type',
    'ggircs_parameters.carbon_tax_act_fuel_type should exist as a table'
);

-- Test table has a primary key
select col_is_pk('ggircs_parameters', 'carbon_tax_act_fuel_type', 'id', 'Column id is Primary Key');

select columns_are('ggircs_parameters'::name, 'carbon_tax_act_fuel_type'::name, array[
    'id'::name,
    'carbon_tax_fuel_type'::name,
    'cta_rate_units'::name,
    'metadata'::name
]);

-- Test column attributes
select col_type_is( 'ggircs_parameters', 'carbon_tax_act_fuel_type', 'id', 'integer', 'carbon_tax_act_fuel_type.id column should be type integer');
select col_hasnt_default('ggircs_parameters', 'carbon_tax_act_fuel_type', 'id', 'carbon_tax_act_fuel_type.id column should not have a default value');

select col_type_is( 'ggircs_parameters', 'carbon_tax_act_fuel_type', 'carbon_tax_fuel_type', 'character varying(1000)', 'carbon_tax_act_fuel_type.carbon_tax_fuel_type column should be type varchar');
select col_hasnt_default('ggircs_parameters', 'carbon_tax_act_fuel_type', 'carbon_tax_fuel_type', 'carbon_tax_act_fuel_type.carbon_tax_fuel_type column should not have a default value');
select col_not_null('ggircs_parameters', 'carbon_tax_act_fuel_type', 'carbon_tax_fuel_type', 'carbon_tax_fuel_type has NOT NULL constraint');

select * from finish();
rollback;
