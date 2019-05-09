-- Deploy ggircs:materialized_view_fuel to pg
-- requires: table_ghgr_import

begin;

-- Fuels from Units
-- todo: explore any other attributes for units
create materialized view ggircs_swrs.fuel as (
  with x as (
    select ghgr_import.id as ghgr_import_id,
           ghgr_import.xml_file as source_xml
    from ggircs_swrs.ghgr_import
    order by ghgr_import_id desc
  )
  select ghgr_import_id, fuel_details.*
  from x,
       xmltable(
           '//Fuel'
           passing source_xml
           columns
             activity_name varchar(1000) path 'name(./ancestor::ActivityData/*)' not null,
             sub_activity_name varchar(1000) path 'name(./ancestor::ActivityData/*/*)' not null,
             unit_name varchar(1000) path 'name(./ancestor::Substance/parent::*/parent::*/parent::*)' not null,
             sub_unit_name varchar(1000) path 'name(./ancestor::Substance/parent::*/parent::*)' not null,
             process_idx integer path 'string(count(./ancestor::Process/preceding-sibling::Process))' not null,
             sub_process_idx integer path 'string(count(./ancestor::SubProcess/preceding-sibling::SubProcess))' not null,
             units_idx integer path 'string(count(./ancestor::Units/preceding-sibling::Units))' not null,
             unit_idx integer path 'string(count(./ancestor::Unit/preceding-sibling::Unit))' not null,
             substances_idx integer path 'string(count(./ancestor::Substance/parent::*/preceding-sibling::*))' not null,
             substance_idx integer path 'string(count(./ancestor::Substance/preceding-sibling::Substance))' not null,
             fuel_idx integer path 'string(count(./preceding-sibling::Fuel))' not null,
             fuel_type varchar(1000) path './FuelType',
             fuel_classification varchar(1000) path './FuelClassification',
             fuel_units varchar(1000) path './FuelUnits',
             annual_fuel_amount varchar(1000) path './AnnualFuelAmount',
             annual_weighted_avg_hhv varchar(1000) path './AnnualWeightedAverageHighHeatingValue',
             alternative_methodology_description varchar(1000) path './AlternativeMethodologyDescription'
         ) as fuel_details
) with no data;

create unique index ggircs_fuel_primary_key on ggircs_swrs.fuel (ghgr_import_id, activity_name, sub_activity_name, unit_name, sub_unit_name, process_idx, sub_process_idx, units_idx, unit_idx, substances_idx, substance_idx, fuel_idx);

comment on materialized view ggircs_swrs.fuel is 'The materialized view containing the information on fuels';
comment on column ggircs_swrs.fuel.ghgr_import_id is 'A foreign key reference to ggircs_swrs.ghgr_import';
comment on column ggircs_swrs.fuel.activity_name is 'The name of the activity (partial fk reference)';
comment on column ggircs_swrs.fuel.sub_activity_name is 'The name of the sub_activity (partial fk reference)';
comment on column ggircs_swrs.fuel.unit_name is 'The name of the unit (partial fk reference)';
comment on column ggircs_swrs.fuel.sub_unit_name is 'The name of the sub_unit (partial fk reference)';
comment on column ggircs_swrs.fuel.process_idx is 'The number of preceding Process siblings before this Process (partial fk reference)';
comment on column ggircs_swrs.fuel.sub_process_idx is 'The number of preceding SubProcess siblings before this SubProcess (partial fk reference)';
comment on column ggircs_swrs.fuel.units_idx is 'The number of preceding Units siblings before this Units (partial fk reference)';
comment on column ggircs_swrs.fuel.unit_idx is 'A foreign key reference to ggircs_swrs.unit (partial fk reference)';
comment on column ggircs_swrs.fuel.substances_idx is 'The number of preceding siblings before the Substances';
comment on column ggircs_swrs.fuel.substance_idx is 'The number of preceding siblings before the Substance';
comment on column ggircs_swrs.fuel.fuel_idx is 'The primary key for the fuel';
comment on column ggircs_swrs.fuel.fuel_type is 'The type of the fuel';
comment on column ggircs_swrs.fuel.fuel_classification is 'The classification of the fuel';
comment on column ggircs_swrs.fuel.fuel_units is 'The units of the fuel';
comment on column ggircs_swrs.fuel.annual_fuel_amount is 'The annual amount of the fuel';
comment on column ggircs_swrs.fuel.annual_weighted_avg_hhv is 'The annual weight avg of the high heating value of the fuel';

commit;
