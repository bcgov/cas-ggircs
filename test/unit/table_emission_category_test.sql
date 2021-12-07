set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(3);

-- exists in swrs schema
select has_table(
    'swrs', 'emission_category',
    'swrs.emission_category should exist as a table'
);

-- primary key
select col_is_pk('swrs', 'emission_category', 'id', 'Column id is Primary Key');

select columns_are('swrs'::name, 'emission_category'::name, array[
  'id'::name,
  'swrs_emission_category'::name,
  'carbon_taxed'::name,
  'category_definition'::name
]);

select * from finish();
rollback;