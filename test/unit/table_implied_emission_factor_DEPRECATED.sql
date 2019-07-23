set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(13);

-- Test table exists in ggircs_swrs schema
select has_table(
    'ggircs_swrs', 'implied_emission_factor',
    'swrs.implied_emission_factor should exist as a table'
);

-- Test table has a primary key
select col_is_pk('ggircs_swrs', 'implied_emission_factor', 'id', 'Column id is Primary Key');

select columns_are('ggircs_swrs'::name, 'implied_emission_factor'::name, array[
    'id'::name,
    'start_date'::name,
    'end_date'::name,
    'implied_emission_factor'::name,
    'fuel_mapping_id'::name
]);

-- Test column attributes
select col_type_is( 'ggircs_swrs', 'implied_emission_factor', 'id', 'integer', 'implied_emission_factor.id column should be type integer');
select col_hasnt_default('ggircs_swrs', 'implied_emission_factor', 'id', 'implied_emission_factor.id column should not have a default value');

select col_type_is( 'ggircs_swrs', 'implied_emission_factor', 'start_date', 'date', 'implied_emission_factor.start_date column should be type date');
select col_hasnt_default('ggircs_swrs', 'implied_emission_factor', 'start_date', 'implied_emission_factor.start_date column should not have a default value');

select col_type_is( 'ggircs_swrs', 'implied_emission_factor', 'end_date', 'date', 'implied_emission_factor.end_date column should be type date');
select col_hasnt_default('ggircs_swrs', 'implied_emission_factor', 'end_date', 'implied_emission_factor.end_date column should not have a default value');

select col_type_is( 'ggircs_swrs', 'implied_emission_factor', 'implied_emission_factor', 'numeric', 'implied_emission_factor.implied_emission_factor column should be type numeric');
select col_hasnt_default('ggircs_swrs', 'implied_emission_factor', 'implied_emission_factor', 'implied_emission_factor.implied_emission_factor column should not have a default value');

select col_type_is( 'ggircs_swrs', 'implied_emission_factor', 'fuel_mapping_id', 'integer', 'implied_emission_factor.fuel_mapping_id column should be type integer');
select col_hasnt_default('ggircs_swrs', 'implied_emission_factor', 'fuel_mapping_id', 'implied_emission_factor.fuel_mapping_id column should not have a default value');

select * from finish();
rollback;
