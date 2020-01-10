-- Deploy ggircs:view_carbon_tax_calculation to pg
-- requires:
    -- schema_ggircs
    -- table_fuel
    -- table_report

begin;

create or replace view swrs.carbon_tax_calculation as
    with fuel as (
        select _report.id                                                    as report_id,
               _organisation.id                                              as organisation_id,
               _facility.id                               as facility_id,
               _activity.id                                                  as activity_id,
               _fuel.id                                                      as fuel_id,
               _emission.id                                                  as emission_id,
               _naics.id                                                     as naics_id,
               _fuel_mapping.fuel_type                                       as fuel_type,
               coalesce(_fuel.annual_fuel_amount, _emission.quantity)        as fuel_amount,
               _report.reporting_period_duration as year,
               _pro_rated_fuel_charge.pro_rated_fuel_charge,
               _pro_rated_fuel_charge.flat_rate,
               _fuel_carbon_tax_details.cta_rate_units                      as units,
               _fuel_carbon_tax_details.unit_conversion_factor              as unit_conversion_factor,
               _fuel_charge.fuel_charge
        from swrs.fuel as _fuel
                 join swrs.unit as _unit
                      on _fuel.unit_id = _unit.id
                 left join swrs.emission as _emission
                      on _fuel.id = _emission.fuel_id
                      and _emission.fuel_mapping_id is not null
                 join swrs.fuel_mapping as _fuel_mapping
                      on _fuel.fuel_mapping_id = _fuel_mapping.id
                      or _emission.fuel_mapping_id = _fuel_mapping.id
                 join swrs.report as _report
                      on _fuel.report_id = _report.id
                 join swrs.organisation as _organisation
                      on _report.id = _organisation.report_id
                 left join swrs.facility as _facility
                      on _report.id = _facility.report_id
                 left join swrs.naics as _naics
                      on _report.id = _naics.report_id
                      and ((_naics.path_context = 'RegistrationData'
                      and (_naics.naics_priority = 'Primary'
                            or _naics.naics_priority = '100.00'
                            or _naics.naics_priority = '100')
                      and (select count(ghgr_import_id)
                           from swrs.naics as __naics
                           where ghgr_import_id = _emission.ghgr_import_id
                           and __naics.path_context = 'RegistrationData'
                           and (__naics.naics_priority = 'Primary'
                            or __naics.naics_priority = '100.00'
                            or __naics.naics_priority = '100')) < 2)
                       or (_naics.path_context='VerifyTombstone'
                           and _naics.naics_code is not null
                           and (select count(ghgr_import_id)
                           from swrs.naics as __naics
                           where ghgr_import_id = _emission.ghgr_import_id
                           and __naics.path_context = 'RegistrationData'
                           and (__naics.naics_priority = 'Primary'
                            or __naics.naics_priority = '100.00'
                            or __naics.naics_priority = '100')) > 1))
                 join swrs.activity as _activity
                      on _unit.activity_id = _activity.id
                 join swrs.pro_rated_fuel_charge as _pro_rated_fuel_charge
                      on _fuel_mapping.id = _pro_rated_fuel_charge.fuel_mapping_id
                      and _report.reporting_period_duration::integer = _pro_rated_fuel_charge.year
                 join swrs.fuel_carbon_tax_details as _fuel_carbon_tax_details
                      on _fuel_mapping.fuel_carbon_tax_details_id = _fuel_carbon_tax_details.id
                 join swrs.fuel_charge as _fuel_charge
                      on _fuel_charge.fuel_mapping_id = _fuel_mapping.id
                      and (concat(_report.reporting_period_duration::text, '-12-31')::date
                      between _fuel_charge.start_date and _fuel_charge.end_date)
    )
select report_id,
       organisation_id,
       fuel.facility_id,
       activity_id,
       fuel_id,
       emission_id,
       naics_id,
       year,
       fuel_type,
       fuel_amount,
       fuel_charge,
       round(pro_rated_fuel_charge / unit_conversion_factor, 4) as pro_rated_fuel_charge,
       unit_conversion_factor,
       round((fuel_amount * flat_rate), 2) as calculated_carbon_tax,
       'Flat Rate Calculation: (fuel_amount * fuel_charge * unit_conversion_factor)'::varchar(1000) as flat_calculation,
       round((fuel_amount * pro_rated_fuel_charge), 2) as pro_rated_calculated_carbon_tax,
       'Pro-rated Rate Calculation: (fuel_amount * pro_rated_fuel_charge * unit_conversion_factor)'::varchar(1000) as pro_rated_calculation
from fuel;

commit;
