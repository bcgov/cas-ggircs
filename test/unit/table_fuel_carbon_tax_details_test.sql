set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(5);

-- exists in swrs schema
select has_table(
    'swrs', 'fuel_carbon_tax_details',
    'swrs.fuel_carbon_tax_details should exist as a table'
);

-- primary key
select col_is_pk('swrs', 'fuel_carbon_tax_details', 'id', 'Column id is Primary Key');

-- foreign keys
select col_is_fk('swrs', 'fuel_carbon_tax_details', 'carbon_tax_act_fuel_type_id', 'has a foreign key to swrs.carbon_tax_act_fuel_type');

select columns_are('swrs'::name, 'fuel_carbon_tax_details'::name, array[
  'id'::name,
  'normalized_fuel_type'::name,
  'state'::name,
  'carbon_taxed'::name,
  'cta_rate_units'::name,
  'unit_conversion_factor'::name,
  'carbon_tax_act_fuel_type_id'::name
]);

SELECT has_index(
  'swrs',
  'fuel_carbon_tax_details',
  'swrs_ctd_ct_fuels_foreign_key',
  'fuel_carbon_tax_details has index: swrs_ctd_ct_fuels_foreign_key' );

select * from finish();
rollback;
