-- Deploy ggircs:materialized_view_fuel to pg
-- requires: materialized_view_unit

BEGIN;

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
             activity_id integer not null path 'count(./ancestor::SubProcess/preceding-sibling::SubProcess)',
             unit_id integer not null path 'count(./ancestor::Unit/preceding-sibling::Unit)',
             id integer not null path 'count(./preceding-sibling::Fuel)',
             fuel_type varchar(1000) path './FuelType',
             fuel_classification varchar(1000) path './FuelClassification',
             fuel_units varchar(1000) path './FuelUnits',
             annual_fuel_amount varchar(1000) path './AnnualFuelAmount',
             annual_weighted_avg_hhv varchar(1000) path './AnnualWeightedAverageHighHeatingValue'
         ) as fuel_details
) with no data;

create unique index ggircs_fuel_primary_key on ggircs_swrs.fuel (ghgr_import_id, activity_id, unit_id, id);

comment on materialized view ggircs_swrs.fuel is 'The materialized view containing the information on fuels';
comment on column ggircs_swrs.fuel.ghgr_import_id is 'A foreign key reference to ggircs_swrs.ghgr_import';
comment on column ggircs_swrs.fuel.activity_id is 'A foreign key reference to ggrics_swrs.activity';
comment on column ggircs_swrs.fuel.unit_id is 'A foreign key reference to ggircs_swrs.unit';
comment on column ggircs_swrs.fuel.id is 'The primary key for the fuel';
comment on column ggircs_swrs.fuel.unit_name is 'The name of the unit';
comment on column ggircs_swrs.fuel.fuel_type is 'The type of the fuel';
comment on column ggircs_swrs.fuel.fuel_classification is 'The classification of the fuel';
comment on column ggircs_swrs.fuel.fuel_units is 'The units of the fuel';
comment on column ggircs_swrs.fuel.annual_fuel_amount is 'The annual amount of the fuel';
comment on column ggircs_swrs.fuel.annual_weighted_avg_hhv is 'The annual weight avg of the high heating value of the fuel';
-- comment on column ggircs_swrs.fuel.xml_hunk is 'The raw xml hunk representing the fuel';

COMMIT;
