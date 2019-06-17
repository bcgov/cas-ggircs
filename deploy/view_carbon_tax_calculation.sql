-- Deploy ggircs:view_carbon_tax_calculation to pg
-- requires:
    -- schema_ggircs
    -- table_fuel
    -- table_report

begin;

create or replace view ggircs.carbon_tax_calculation as
    with fuel as (
        select _organisation.id                           as organisation_id,
               _single_facility.id                        as single_facility_id,
               _lfo_facility.id                           as lfo_facility_id,
               _naics.id                                  as naics_id,
               _naics_mapping.id                          as naics_mapping_id,
               _fuel.fuel_type,
               _fuel.annual_fuel_amount                   as amount,
               _report.reporting_period_duration::integer as year,
               ctr.pro_rated_carbon_tax_rate              as pro_rated_ctr,
               ief.pro_rated_implied_emission_factor      as pro_rated_ief
        from ggircs.fuel as _fuel
                 join ggircs_swrs.fuel_mapping as _fuel_mapping
                      on _fuel.fuel_type = _fuel_mapping.fuel_type
                 join ggircs.report as _report
                      on _fuel.report_id = _report.id
                 left join ggircs.organisation as _organisation
                      on _report.id = _organisation.report_id
                 left join ggircs.lfo_facility as _lfo_facility
                      on _report.id = _lfo_facility.report_id
                 left join ggircs.single_facility as _single_facility
                      on _report.id = _single_facility.report_id
                 left join ggircs.naics as _naics
                      on _report.id = _naics.report_id
                 left join ggircs_swrs.naics_mapping as _naics_mapping
                      on _naics.naics_mapping_id = _naics_mapping.id
                 join ggircs.pro_rated_carbon_tax_rate as ctr
                      on _fuel.fuel_type = ctr.fuel_type
                        and _report.reporting_period_duration::integer = ctr.reporting_year
                 join ggircs.pro_rated_implied_emission_factor as ief
                      on ief.fuel_mapping_id = _fuel_mapping.id
                        and _report.reporting_period_duration::integer = ief.reporting_year
    )
select fuel.organisation_id,
       fuel.single_facility_id,
       fuel.lfo_facility_id,
       fuel.naics_id,
       fuel.naics_mapping_id,
       fuel.year,
       fuel.fuel_type,
       fuel.amount,
       (fuel.amount * pro_rated_ctr * pro_rated_ief) as calculated_carbon_tax
from fuel;
commit;
