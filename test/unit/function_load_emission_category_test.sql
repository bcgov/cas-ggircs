set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(4);

-- exists in swrs schema
select has_function(
    'swrs_transform', 'load_emission_category',
    'swrs_transform.load_emission_category should exist as a function'
);

create schema swrs_load;
create table swrs_load.emission_category (
  id integer primary key,
  swrs_emission_category varchar(1000),
  carbon_taxed boolean default true,
  category_definition varchar(100000)
);

select swrs_transform.load_emission_category();

select is (
  (select count(*) from swrs_load.emission_category),
  8::bigint,
  '8 records were created by swrs_tranform.load_emission_category'
);

select results_eq(
  $$
    select swrs_emission_category from swrs_load.emission_category where carbon_taxed = true
  $$,
  Array[
    'BC_ScheduleB_GeneralStationaryCombustionEmissions'::varchar,
    'BC_ScheduleB_VentingEmissions'::varchar,
    'BC_ScheduleB_FlaringEmissions'::varchar,
    'BC_ScheduleB_OnSiteTransportationEmissions'::varchar,
    'BC_ScheduleB_WasteEmissions'::varchar
  ],
  'The proper records were created as carbon_taxed=true'
);

select results_eq(
  $$
    select swrs_emission_category from swrs_load.emission_category where carbon_taxed = false
  $$,
  Array[
    'BC_ScheduleB_IndustrialProcessEmissions'::varchar,
    'BC_ScheduleB_FugitiveEmissions'::varchar,
    'BC_ScheduleB_WastewaterEmissions'::varchar
  ],
  'The proper records were created as carbon_taxed=true'
);

select * from finish();
rollback;
