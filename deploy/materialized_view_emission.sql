-- Deploy ggircs:materialized_view_emission to pg
-- requires: materialized_view_fuel

begin;

-- Emissions from Fuel
create materialized view ggircs_swrs.emission as (
with x as (
  select
       ghgr_import_id,
       id  as fuel_id,
       unit_id,
       activity_id,
       fuel_type,
       fuel_xml
  from fuel
  order by ghgr_import_id desc
)
select
      row_number() over (order by x.fuel_id asc) as id,
      x.*,
      emission_details.emission_type,
      emission_details.gas_type,
      emission_details.methodology,
      emission_details.not_applicable,
      emission_details.quantity,
      emission_details.calculated_quantity,
      CAST(emission_details.groups as text) as emission_category
from x,
     xmltable(
       '/Fuel/Emissions/Emission'
       passing fuel_xml
       columns
           gas_type text path 'GasType[normalize-space(.)]',
           emission_type text path '../@EmissionsType[normalize-space(.)]',
           methodology text path 'Methodology[normalize-space(.)]',
           not_applicable boolean path 'NotApplicable[normalize-space(.)]',
           quantity numeric path 'Quantity[normalize-space(.)]' default 0,
           calculated_quantity numeric path 'CalculatedQuantity[normalize-space(.)]' default 0,
           groups xml path 'Groups/EmissionGroupTypes/text()[contains(normalize-space(.), "BC_ScheduleB_")]',
           emission_xml xml path '.'
    ) as emission_details
);

create unique index ggircs_emission_primary_key on ggircs_swrs.emission (id);

commit;
