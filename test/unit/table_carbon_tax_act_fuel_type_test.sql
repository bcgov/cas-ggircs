begin;
select plan(8);

-- Test table exists in swrs_utility schema
select has_table(
    'swrs_utility', 'carbon_tax_act_fuel_type',
    'swrs_utility.carbon_tax_act_fuel_type should exist as a table'
);

-- Test table has a primary key
select col_is_pk('swrs_utility', 'carbon_tax_act_fuel_type', 'id', 'Column id is Primary Key');

select columns_are('swrs_utility'::name, 'carbon_tax_act_fuel_type'::name, array[
    'id'::name,
    'carbon_tax_fuel_type'::name
]);

-- Test column attributes
select col_type_is( 'swrs_utility', 'carbon_tax_act_fuel_type', 'id', 'integer', 'carbon_tax_act_fuel_type.id column should be type integer');
select col_hasnt_default('swrs_utility', 'carbon_tax_act_fuel_type', 'id', 'carbon_tax_act_fuel_type.id column should not have a default value');

select col_type_is( 'swrs_utility', 'carbon_tax_act_fuel_type', 'carbon_tax_fuel_type', 'character varying(1000)', 'carbon_tax_act_fuel_type.carbon_tax_fuel_type column should be type varchar');
select col_hasnt_default('swrs_utility', 'carbon_tax_act_fuel_type', 'carbon_tax_fuel_type', 'carbon_tax_act_fuel_type.carbon_tax_fuel_type column should not have a default value');
select col_not_null('swrs_utility', 'carbon_tax_act_fuel_type', 'carbon_tax_fuel_type', 'carbon_tax_fuel_type has NOT NULL constraint');

select * from finish();
rollback;
