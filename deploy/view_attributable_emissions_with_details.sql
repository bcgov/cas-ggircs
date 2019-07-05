-- Deploy ggircs:view_attributable_emissions_with_details to pg
-- requires: schema_ggircs

begin;

create or replace view ggircs.attributable_emissions_with_details as
select
       ae.id as emission_id,
       org.business_legal_name,
       fc.facility_name,
       fc.facility_type,
       ac.process_name,
       ac.sub_process_name,
       ae.emission_type,
       ae.gas_type,
       ae.quantity,
       ae.calculated_quantity,
       ae.methodology,
       regexp_replace(
         regexp_replace(
          ae.emission_category, 'BC_ScheduleB_', ''), 'Emissions', ''
         )::varchar(1000) as emission_category,
       rp.reporting_period_duration,
       f.fuel_type,
       f.fuel_units,
       f.fuel_classification,
       f.fuel_description,
       f.annual_fuel_amount,
       f.annual_weighted_avg_carbon_content,
       f.annual_weighted_avg_hhv,
       f.annual_steam_generation,
       f.alternative_methodology_description,
        n.naics_classification,
       n.naics_code,
       u.unit_name,
       u.id as unit_id,
       ae.ghgr_import_id,
       rp.id as report_id,
       org.id as organisation_id,
       fc.id as facility_id,
       rp.swrs_report_id,
       org.swrs_organisation_id,
       fc.swrs_facility_id

from ggircs.attributable_emission as ae
       left join ggircs.fuel as f on ae.fuel_id = f.id
       left join ggircs.activity as ac on ac.id = ae.activity_id
       left join ggircs.report as rp on rp.id = ae.report_id
       left join ggircs.facility as fc on fc.id = ae.facility_id
       left join ggircs.organisation as org on org.id = ae.organisation_id
       left join ggircs.unit as u on u.id = ae.unit_id
       left join ggircs.naics as n on n.id = ae.naics_id;

commit;
