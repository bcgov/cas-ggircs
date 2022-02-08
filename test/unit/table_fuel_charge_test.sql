set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(5);

-- exists in swrs_utility schema
select has_table(
    'swrs_utility', 'fuel_charge',
    'swrs_utility.fuel_charge should exist as a table'
);

-- primary key
select col_is_pk('swrs_utility', 'fuel_charge', 'id', 'Column id is Primary Key');

-- foreign keys
select col_is_fk('swrs_utility', 'fuel_charge', 'carbon_tax_act_fuel_type_id', 'has a foreign key to swrs_utility.carbon_tax_act_fuel_type');

select columns_are('swrs_utility'::name, 'fuel_charge'::name, array[
  'id'::name,
  'fuel_charge'::name,
  'start_date'::name,
  'end_date'::name,
  'carbon_tax_act_fuel_type_id'::name,
  'metadata'::name
]);

SELECT has_index(
  'swrs_utility',
  'fuel_charge',
  'swrs_utility_fuel_charge_ct_fuels_foreign_key',
  'fuel_charge has index: swrs_utility_fuel_charge_ct_fuels_foreign_key' );

select * from finish();
rollback;
