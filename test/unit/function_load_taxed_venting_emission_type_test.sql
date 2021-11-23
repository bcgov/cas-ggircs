set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(2);

-- exists in swrs schema
select has_function(
    'swrs_transform', 'load_taxed_venting_emission_type',
    'swrs_transform.load_taxed_venting_emission_type should exist as a function'
);

create schema swrs_load;
create table swrs_load.taxed_venting_emission_type (
  id integer primary key,
  taxed_emission_type varchar(1000)
);

select swrs_transform.load_taxed_venting_emission_type();

select is (
  (select count(*) from swrs_load.taxed_venting_emission_type),
  16::bigint,
  '16 records were created by swrs_tranform.load_taxed_venting_emission_type'
);

select * from finish();
rollback;
