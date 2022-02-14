set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(5);

-- exists in ggircs_parameters schema
select has_table(
    'ggircs_parameters', 'fuel_carbon_tax_detail',
    'ggircs_parameters.fuel_carbon_tax_detail should exist as a table'
);

-- primary key
select col_is_pk('ggircs_parameters', 'fuel_carbon_tax_detail', 'id', 'Column id is Primary Key');

-- foreign keys
select col_is_fk('ggircs_parameters', 'fuel_carbon_tax_detail', 'carbon_tax_act_fuel_type_id', 'has a foreign key to ggircs_parameters.carbon_tax_act_fuel_type');

select columns_are('ggircs_parameters'::name, 'fuel_carbon_tax_detail'::name, array[
  'id'::name,
  'normalized_fuel_type'::name,
  'state'::name,
  'cta_rate_units'::name,
  'unit_conversion_factor'::name,
  'carbon_tax_act_fuel_type_id'::name
]);

SELECT has_index(
  'ggircs_parameters',
  'fuel_carbon_tax_detail',
  'ggircs_parameters_ctd_ct_fuels_fkey',
  'fuel_carbon_tax_detail has index: ggircs_parameters_ctd_ct_fuels_fkey' );

select * from finish();
rollback;
