-- Deploy ggircs:materialized_view_emission to pg
-- requires: materialized_view_fuel

begin;

-- Emissions from Fuel
create materialized view ggircs_swrs.emission as (
with x as (
    select ghgr_import.id as ghgr_import_id,
           ghgr_import.xml_file as source_xml
    from ggircs_swrs.ghgr_import
    order by ghgr_import_id desc
  )
select
      x.ghgr_import_id,
      emission_details.process_idx,
      emission_details.sub_process_idx,
      emission_details.unit_idx,
      emission_details.fuel_idx,
      emission_details.idx,
      emission_details.emission_type,
      emission_details.gas_type,
      emission_details.methodology,
      emission_details.not_applicable,
      emission_details.quantity,
      emission_details.calculated_quantity,
      CAST(emission_details.groups as varchar(1000)) as emission_category
from x,
     xmltable(
       '//Emission'
       passing source_xml
       columns
           process_idx integer path 'string(count(./ancestor::Process/preceding-sibling::Process))' not null,
           sub_process_idx integer path 'string(count(./ancestor::SubProcess/preceding-sibling::SubProcess))' not null,
           unit_idx integer path 'string(count(./ancestor::Unit/preceding-sibling::Unit))' not null,
           fuel_idx integer path 'string(count(./ancestor::Fuel/preceding-sibling::Fuel))' not null,
           idx integer  path 'string(count(./preceding-sibling::Emission))' not null,
           gas_type varchar(1000) path 'GasType[normalize-space(.)]',
           emission_type varchar(1000) path '../@EmissionsType[normalize-space(.)]',
           methodology varchar(1000) path 'Methodology[normalize-space(.)]',
           not_applicable boolean path 'NotApplicable[normalize-space(.)]',
           quantity numeric(1000,0) path 'Quantity[normalize-space(.)]' default 0,
           calculated_quantity numeric(1000,0) path 'CalculatedQuantity[normalize-space(.)]' default 0,
           groups xml path 'Groups/EmissionGroupTypes/text()[contains(normalize-space(.), "BC_ScheduleB_")]'
    ) as emission_details
) with no data;

create unique index ggircs_emission_primary_key on ggircs_swrs.emission (ghgr_import_id, process_idx, sub_process_idx, unit_idx, fuel_idx, idx);

comment on materialized view ggircs_swrs.emission is 'The materialized view containing the information on emissions';
comment on column ggircs_swrs.emission.ghgr_import_id is 'A foreign key reference to ggircs_swrs.ghgr_import';
comment on column ggircs_swrs.emission.process_idx is 'The number of preceding Process siblings before this activity';
comment on column ggircs_swrs.emission.sub_process_idx is 'The number of preceding SubProcess siblings before this activity';
comment on column ggircs_swrs.emission.unit_idx is 'The number of preceding Unit siblings before this activity';
comment on column ggircs_swrs.emission.fuel_idx is 'The number of preceding Fuel siblings before this activity';
comment on column ggircs_swrs.emission.idx is 'The number of preceding Emission siblings before this activity';
comment on column ggircs_swrs.emission.emission_type is 'The type of the emission';
comment on column ggircs_swrs.emission.gas_type is 'The type of the gas';
comment on column ggircs_swrs.emission.methodology is 'The emission methodology';
comment on column ggircs_swrs.emission.not_applicable is 'Is the emission applicable/NA';
comment on column ggircs_swrs.emission.quantity is 'The quantity of the emission';
comment on column ggircs_swrs.emission.calculated_quantity is 'The CO2 Equivalent quantity of the emission';
comment on column ggircs_swrs.emission.emission_category is 'The emissions category ';

commit;
