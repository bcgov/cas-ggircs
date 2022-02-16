set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(3);

select has_view( 'swrs', 'fuel_charge', 'fuel_charge view exists' );

select isnt_empty(
  'select * from swrs.fuel_charge',
  'There is data in the fuel_charge view'
);

select results_eq(
  $$
    select * from swrs.fuel_charge
  $$,
  $$
    select * from ggircs_parameters.fuel_charge
  $$,
  'The swrs.fuel_charge view contains the same data as the ggircs_parameters.fuel_charge table'
);

select * from finish();
rollback;
