set client_min_messages to warning;
create extension if not exists pgtap;

begin;

select plan(3);

select has_function(
  'ggircs_parameters', 'create_fuel_mapping_cascade',
  'Function create_fuel_mapping_cascade should exist'
);

insert into swrs.report (id, swrs_report_id, reporting_period_duration) values (1, 1, 2020), (2, 2, 2020);
insert into swrs.fuel (id, report_id, fuel_type, fuel_mapping_id)
values (1, 1, 'No Mapping 1', null), (2, 2, 'No Mapping 1', null), (3, 2, 'Still No Mapping', null);

select ggircs_parameters.create_fuel_mapping_cascade('No Mapping 1', 1);

select results_eq(
  $$
    select fuel_type, fuel_carbon_tax_detail_id from ggircs_parameters.fuel_mapping order by id desc limit 1;
  $$,
  $$
    values ('No Mapping 1'::varchar, 1::integer);
  $$,
  'Mutation should add the unmapped fuel type to the fuel_mapping table with the correct carbon_tax_details_id'
);

select results_eq(
  $$
    select fuel_type from swrs.fuel where fuel_mapping_id is null
  $$,
  $$
    values ('Still No Mapping'::varchar)
  $$,
  'Mutation should cascade the change to all fuel records of the same fuel_type and leave other fuels unaffected'
);

select finish();

rollback;
reset client_min_messages;
