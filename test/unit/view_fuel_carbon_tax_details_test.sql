set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(3);

select has_view( 'swrs', 'fuel_carbon_tax_details', 'fuel_carbon_tax_details view exists' );

select isnt_empty(
  'select * from swrs.fuel_carbon_tax_details',
  'There is data in the fuel_carbon_tax_details view'
);

select results_eq(
  $$
    select * from swrs.fuel_carbon_tax_details
  $$,
  $$
    select * from ggircs_parameters.fuel_carbon_tax_detail
  $$,
  'The swrs.fuel_carbon_tax_details view contains the same data as the ggircs_parameters.fuel_carbon_tax_details table'
);

select * from finish();
rollback;
