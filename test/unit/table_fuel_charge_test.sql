set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(5);

-- exists in ggircs_parameters schema
select has_table(
    'ggircs_parameters', 'fuel_charge',
    'ggircs_parameters.fuel_charge should exist as a table'
);

-- primary key
select col_is_pk('ggircs_parameters', 'fuel_charge', 'id', 'Column id is Primary Key');

-- foreign keys
select col_is_fk('ggircs_parameters', 'fuel_charge', 'carbon_tax_act_fuel_type_id', 'has a foreign key to ggircs_parameters.carbon_tax_act_fuel_type');

select columns_are('ggircs_parameters'::name, 'fuel_charge'::name, array[
  'id'::name,
  'fuel_charge'::name,
  'start_date'::name,
  'end_date'::name,
  'carbon_tax_act_fuel_type_id'::name,
  'metadata'::name
]);

SELECT has_index(
  'ggircs_parameters',
  'fuel_charge',
  'ggircs_parameters_fuel_charge_ct_fuels_foreign_key',
  'fuel_charge has index: ggircs_parameters_fuel_charge_ct_fuels_foreign_key' );

select * from finish();
rollback;
