set client_min_messages to warning;
create extension if not exists pgtap;

begin;

select plan(4);

select has_function(
  'ggircs_parameters', 'unmapped_fuel',
  'Function facility_application_by_reporting_year should exist'
);

insert into swrs.report (id, swrs_report_id, reporting_period_duration) values (1, 1, 2013), (2, 2, 2020), (3, 3, 2021);

insert into swrs.fuel (id, report_id, fuel_type, fuel_mapping_id)
values (1, 1, 'Other', null), (2, 2, 'No Mapping 1', null), (3, 3, 'No Mapping 2', null), (4, 3, 'Acetylene', 1);

select fuel_type from ggircs_parameters.unmapped_fuel();

select results_eq(
  $$
    select fuel_type from ggircs_parameters.unmapped_fuel();
  $$,
  $$
    values ('No Mapping 1'), ('No Mapping 2');
  $$,
  'unmapped_fuel() should return fuel types that are not mapped to a fuel type in the fuel_mapping table.'
);

select is(
  (
    select count(*) from ggircs_parameters.unmapped_fuel() where fuel_type = 'Too old'
  ),
  0::bigint,
  'The fuel_type "Other" should not be returned by unmapped_fuel()'
);

select is(
  (
    select count(*) from ggircs_parameters.unmapped_fuel() where fuel_mapping_id is not null
  ),
  0::bigint,
  'Mapped fuels should not be returned'
);

select finish();

rollback;
reset client_min_messages;
