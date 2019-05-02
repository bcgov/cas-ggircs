-- Deploy ggircs:materialized_view_fuel to pg
-- requires: table_ghgr_import

BEGIN;

-- Fuels from Units
-- todo: explore any other attributes for units
create materialized view ggircs_private.fuel as (
  with x as (
    select report_id,
           id              as unit_id,
           activity_id,
           swrs_report_id,
           swrs_report_history_id,
           activity,
           unit_name,
           sub_activity,
           unit_xml
    from unit
    order by report_id desc
  )
  select row_number() over (order by x.unit_id asc) as id,
         report_id,
         swrs_report_id,
         activity_id,
         unit_id,
         unit_name,
         activity,
         sub_activity,
         fuel_details.*,
         swrs_report_history_id

  from x,
       xmltable(
         '/ReportData'
         ),
       xmltable(
           '/Unit/Fuels/Fuel'
           passing unit_xml
           columns
             fuel_type text path './FuelType',
             fuel_classification text path './FuelClassification',
             fuel_units text path './FuelUnits',
             annual_fuel_amount text path './AnnualFuelAmount',
             annual_weighted_avg_hhv text path './AnnualWeightedAverageHighHeatingValue',
             fuel_xml xml path '.'
         ) as fuel_details
);

create unique index ggircs_fuel_primary_key on ggircs_private.fuel (id);

COMMIT;
