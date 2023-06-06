set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(3);

-- exists in ggircs_parameters schema
select has_table(
    'ggircs_parameters', 'gwp',
    'ggircs_parameters.gwp should exist as a table'
);

-- primary key
select col_is_pk('ggircs_parameters', 'gwp', 'id', 'Column id is Primary Key');

select columns_are('ggircs_parameters'::name, 'gwp'::name, array[
  'id'::name,
  'gas_type'::name,
  'gwp'::name
]);

select * from finish();
rollback;
