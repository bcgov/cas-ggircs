set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(3);

select has_view( 'swrs', 'carbon_tax_act_fuel_type', 'carbon_tax_act_fuel_type view exists' );

select isnt_empty(
  'select * from swrs.carbon_tax_act_fuel_type',
  'There is data in the carbon_tax_act_fuel_type view'
);

select results_eq(
  $$
    select * from swrs.carbon_tax_act_fuel_type
  $$,
  $$
    select * from ggircs_parameters.carbon_tax_act_fuel_type
  $$,
  'The swrs.carbon_tax_act_fuel_type view contains the same data as the ggircs_parameters.carbon_tax_act_fuel_type table'
);

select * from finish();
rollback;
