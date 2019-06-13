set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(17);

-- Test table exists in ggircs_swrs schema
select has_table(
    'ggircs_swrs', 'fuel_mapping',
    'ggircs_swrs.fuel_mapping should exist as a table'
);

-- Test table has a primary key
select col_is_pk('ggircs_swrs', 'fuel_mapping', 'id', 'Column id is Primary Key');

select columns_are('ggircs_swrs'::name, 'fuel_mapping'::name, array[
    'id'::name,
    'fuel_type'::name,
    'normalized_fuel_type'::name,
    'state'::name,
    'carbon_taxed'::name,
    'cta_mapping'::name,
    'cta_rate_units'::name
]);

-- Test column attributes
select col_type_is( 'ggircs_swrs', 'fuel_mapping', 'id', 'integer', 'fuel_mapping.id column should be type integer');
select col_hasnt_default('ggircs_swrs', 'fuel_mapping', 'id', 'fuel_mapping.id column should not have a default value');

select col_type_is( 'ggircs_swrs', 'fuel_mapping', 'fuel_type', 'character varying(1000)', 'fuel_mapping.fuel_type column should be type character varying(1000)');
select col_hasnt_default('ggircs_swrs', 'fuel_mapping', 'fuel_type', 'fuel_mapping.fuel_type column should not have a default value');

select col_type_is( 'ggircs_swrs', 'fuel_mapping', 'normalized_fuel_type', 'character varying(1000)', 'fuel_mapping.normalized_fuel_type column should be type character varying(1000)');
select col_hasnt_default('ggircs_swrs', 'fuel_mapping', 'normalized_fuel_type', 'fuel_mapping.normalized_fuel_type column should not have a default value');

select col_type_is( 'ggircs_swrs', 'fuel_mapping', 'state', 'character varying(1000)', 'fuel_mapping.state column should be type character varying(1000)');
select col_hasnt_default('ggircs_swrs', 'fuel_mapping', 'state', 'fuel_mapping.state column should not have a default value');

select col_type_is( 'ggircs_swrs', 'fuel_mapping', 'carbon_taxed', 'character varying(1000)', 'fuel_mapping.carbon_taxed column should be type character varying(1000)');
select col_hasnt_default('ggircs_swrs', 'fuel_mapping', 'carbon_taxed', 'fuel_mapping.carbon_taxed column should not have a default value');

select col_type_is( 'ggircs_swrs', 'fuel_mapping', 'cta_mapping', 'character varying(1000)', 'fuel_mapping.cta_mapping column should be type character varying(1000)');
select col_hasnt_default('ggircs_swrs', 'fuel_mapping', 'cta_mapping', 'fuel_mapping.cta_mapping column should not have a default value');

select col_type_is( 'ggircs_swrs', 'fuel_mapping', 'cta_rate_units', 'character varying(1000)', 'fuel_mapping.cta_rate_units column should be type character varying(1000)');
select col_hasnt_default('ggircs_swrs', 'fuel_mapping', 'cta_rate_units', 'fuel_mapping.cta_rate_units column should not have a default value');

select * from finish();
rollback;
