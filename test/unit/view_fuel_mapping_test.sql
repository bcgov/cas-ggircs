set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(3);

select has_view( 'swrs', 'fuel_mapping', 'fuel_mapping view exists' );

select isnt_empty(
  'select * from swrs.fuel_mapping',
  'There is data in the fuel_mapping view'
);

select results_eq(
  $$
    select * from swrs.fuel_mapping
  $$,
  $$
    select * from ggircs_parameters.fuel_mapping
  $$,
  'The swrs.fuel_mapping view contains the same data as the ggircs_parameters.fuel_mapping table'
);

select * from finish();
rollback;
