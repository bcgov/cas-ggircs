set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(3);

-- exists in ggircs_parameters schema
select has_table(
    'ggircs_parameters', 'emission_category',
    'ggircs_parameters.emission_category should exist as a table'
);

-- primary key
select col_is_pk('ggircs_parameters', 'emission_category', 'id', 'Column id is Primary Key');

select columns_are('ggircs_parameters'::name, 'emission_category'::name, array[
  'id'::name,
  'swrs_emission_category'::name,
  'carbon_taxed'::name,
  'category_definition'::name
]);

select * from finish();
rollback;
