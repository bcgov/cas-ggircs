set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(3);

select has_view( 'swrs', 'naics_naics_category', 'naics_naics_category view exists' );

select isnt_empty(
  'select * from swrs.naics_naics_category',
  'There is data in the naics_naics_category view'
);

select results_eq(
  $$
    select * from swrs.naics_naics_category
  $$,
  $$
    select * from ggircs_parameters.naics_naics_category
  $$,
  'The swrs.naics_naics_category view contains the same data as the ggircs_parameters.naics_naics_category table'
);

select * from finish();
rollback;
