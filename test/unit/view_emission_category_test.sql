set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(3);

select has_view( 'swrs', 'emission_category', 'emission_category view exists' );

select isnt_empty(
  'select * from swrs.emission_category',
  'There is data in the emission_category view'
);

select results_eq(
  $$
    select * from swrs.emission_category
  $$,
  $$
    select * from ggircs_parameters.emission_category
  $$,
  'The swrs.emission_category view contains the same data as the ggircs_parameters.emission_category table'
);

select * from finish();
rollback;
