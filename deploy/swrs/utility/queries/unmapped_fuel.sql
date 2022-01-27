-- Deploy ggircs:swrs/utility/queries/unmapped_fuel to pg
-- requires: swrs/public/table/fuel
-- requires: swrs/utility/schema

begin;

create or replace function swrs_utility.unmapped_fuel()
  returns setof text
  as $$
    select distinct on (fuel_type) fuel.fuel_type from swrs.fuel
    join swrs.report
    on fuel.report_id = report.id
    left join swrs.fuel_mapping fm
    on fuel.fuel_mapping_id = fm.id
    where
      (
        fuel.fuel_type not in (select fuel_type from swrs.fuel_mapping)
        or fm.fuel_carbon_tax_details_id is null
      )
      and report.reporting_period_duration > 2014;
  $$ language 'sql' stable;

grant execute on function swrs_utility.unmapped_fuel to ggircs_user;

comment on function swrs_utility.unmapped_fuel is 'A custom function to return fuel types that are not mapped to a fuel type in the fuel_mapping table.';

commit;
