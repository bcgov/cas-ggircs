set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(9);

-- Test table exists in swrs_utility schema
select has_table(
    'swrs_utility', 'fuel_mapping',
    'swrs_utility.fuel_mapping should exist as a table'
);

-- Test table has a primary key
select col_is_pk('swrs_utility', 'fuel_mapping', 'id', 'Column id is Primary Key');

select columns_are('swrs_utility'::name, 'fuel_mapping'::name, array[
    'id'::name,
    'fuel_type'::name,
    'fuel_carbon_tax_detail_id'::name
]);

-- Test column attributes
select col_type_is( 'swrs_utility', 'fuel_mapping', 'id', 'integer', 'fuel_mapping.id column should be type integer');
select col_hasnt_default('swrs_utility', 'fuel_mapping', 'id', 'fuel_mapping.id column should not have a default value');

select col_type_is( 'swrs_utility', 'fuel_mapping', 'fuel_type', 'character varying(1000)', 'fuel_mapping.fuel_type column should be type character varying(1000)');
select col_hasnt_default('swrs_utility', 'fuel_mapping', 'fuel_type', 'fuel_mapping.fuel_type column should not have a default value');

select col_type_is( 'swrs_utility', 'fuel_mapping', 'fuel_carbon_tax_detail_id', 'integer', 'fuel_mapping.fuel_carbon_tax_detail_id column should be type integer');
select col_hasnt_default('swrs_utility', 'fuel_mapping', 'fuel_carbon_tax_detail_id', 'fuel_mapping.fuel_carbon_tax_detail_id column should not have a default value');

select * from finish();
rollback;
