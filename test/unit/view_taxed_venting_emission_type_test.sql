set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(3);

select has_view( 'swrs', 'taxed_venting_emission_type', 'taxed_venting_emission_type view exists' );

select isnt_empty(
  'select * from swrs.taxed_venting_emission_type',
  'There is data in the taxed_venting_emission_type view'
);

select results_eq(
  $$
    select * from swrs.taxed_venting_emission_type
  $$,
  $$
    select * from ggircs_parameters.taxed_venting_emission_type
  $$,
  'The swrs.taxed_venting_emission_type view contains the same data as the ggircs_parameters.taxed_venting_emission_type table'
);

select * from finish();
rollback;
