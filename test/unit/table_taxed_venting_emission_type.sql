set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(3);

-- exists in swrs schema
select has_table(
    'swrs', 'taxed_venting_emission_type',
    'swrs.taxed_venting_emission_type should exist as a table'
);

-- primary key
select col_is_pk('swrs', 'taxed_venting_emission_type', 'id', 'Column id is Primary Key');

select columns_are('swrs'::name, 'taxed_venting_emission_type'::name, array[
  'id'::name,
  'taxed_venting_emission_type'::name
]);

select * from finish();
rollback;
