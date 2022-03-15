-- Deploy ggircs:swrs/parameters/queries/unmapped_fuel to pg
-- requires: swrs/parameters/schema
-- requires: swrs/parameters/table/fuel_mapping
-- requires: swrs/public/table/fuel

begin;

create or replace function ggircs_parameters.unmapped_fuel()
  returns setof ggircs_parameters.unmapped_fuel_return
  as $$
    select distinct on (fuel_type) fuel.fuel_type, fm.id from swrs.fuel
    left join ggircs_parameters.fuel_mapping fm
    on fuel.fuel_mapping_id = fm.id
    where
      (
        fuel.fuel_type not in (select fuel_type from ggircs_parameters.fuel_mapping)
        or fm.fuel_carbon_tax_detail_id is null
      )
      and fuel.fuel_type != 'Other'
  $$ language 'sql' stable;

comment on function ggircs_parameters.unmapped_fuel is 'A custom function to return fuel types that are not mapped to a fuel type in the fuel_mapping table.';

commit;
