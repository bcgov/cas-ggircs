set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(5);

-- exists in swrs schema
select has_table(
    'swrs', 'fuel_charge',
    'swrs.fuel_charge should exist as a table'
);

-- primary key
select col_is_pk('swrs', 'fuel_charge', 'id', 'Column id is Primary Key');

-- foreign keys
select col_is_fk('swrs', 'fuel_charge', 'carbon_tax_act_fuel_type_id', 'has a foreign key to swrs.carbon_tax_act_fuel_type');

select columns_are('swrs'::name, 'fuel_charge'::name, array[
  'id'::name,
  'fuel_charge'::name,
  'start_date'::name,
  'end_date'::name,
  'carbon_tax_act_fuel_type_id'::name,
  'metadata'::name
]);

SELECT has_index(
  'swrs',
  'fuel_charge',
  'swrs_fuel_charge_ct_fuels_foreign_key',
  'fuel_charge has index: swrs_fuel_charge_ct_fuels_foreign_key' );

select * from finish();
rollback;
