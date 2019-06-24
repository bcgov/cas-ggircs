-- Deploy ggircs:view_carbon_tax_calculation to pg
-- requires:
    -- schema_ggircs
    -- table_fuel
    -- table_report

begin;

create or replace view ggircs.carbon_tax_calculation as
    with fuel as (
        select _report.id                                                 as report_id,
               _organisation.id                                              as organisation_id,
               _single_facility.id                                           as single_facility_id,
               _activity.id                                                  as activity_id,
               _fuel.id                                                      as fuel_id,
               _emission.id                                                  as emission_id,
               _naics.id                                                     as naics_id,
               _fuel_mapping.fuel_type                                       as fuel_type,
               coalesce(_fuel.annual_fuel_amount, _emission.quantity)        as fuel_amount,
               _report.reporting_period_duration::integer as year,
               _pro_rated_fuel_charge.pro_rated_fuel_charge,
               _pro_rated_fuel_charge.flat_rate
        from ggircs.fuel as _fuel
                 join ggircs.unit as _unit
                      on _fuel.unit_id = _unit.id
                 left join ggircs.emission as _emission
                      on _fuel.id = _emission.fuel_id
                      and _emission.fuel_mapping_id is not null
                 join ggircs_swrs.fuel_mapping as _fuel_mapping
                      on _fuel.fuel_mapping_id = _fuel_mapping.id
                      or _emission.fuel_mapping_id = _fuel_mapping.id
                 join ggircs.report as _report
                      on _fuel.report_id = _report.id
                 join ggircs.organisation as _organisation
                      on _report.id = _organisation.report_id
                 inner join ggircs.single_facility as _single_facility
                      on _report.id = _single_facility.report_id
                 join ggircs.naics as _naics
                      on _report.id = _naics.report_id
                      and ((_naics.path_context = 'RegistrationData'
                      and (_naics.naics_priority = 'Primary'
                            or _naics.naics_priority = '100.00'
                            or _naics.naics_priority = '100')
                      and (select count(ghgr_import_id)
                           from ggircs_swrs.naics as __naics
                           where ghgr_import_id = _emission.ghgr_import_id
                           and __naics.path_context = 'RegistrationData'
                           and (__naics.naics_priority = 'Primary'
                            or __naics.naics_priority = '100.00'
                            or __naics.naics_priority = '100')) < 2)
                       or (_naics.path_context='VerifyTombstone'
                           and _naics.naics_code is not null
                           and (select count(ghgr_import_id)
                           from ggircs_swrs.naics as __naics
                           where ghgr_import_id = _emission.ghgr_import_id
                           and __naics.path_context = 'RegistrationData'
                           and (__naics.naics_priority = 'Primary'
                            or __naics.naics_priority = '100.00'
                            or __naics.naics_priority = '100')) > 1))
                 join ggircs.activity as _activity
                      on _unit.activity_id = _activity.id
                 join ggircs.pro_rated_fuel_charge as _pro_rated_fuel_charge
                      on _fuel_mapping.id = _pro_rated_fuel_charge.fuel_mapping_id
                      and _report.reporting_period_duration::integer = _pro_rated_fuel_charge.rpd
    )
select report_id,
       organisation_id,
       single_facility_id,
       activity_id,
       fuel_id,
       emission_id,
       naics_id,
       year,
       fuel_type,
       fuel_amount,
       (fuel_amount * flat_rate) as calculated_carbon_tax,
       (fuel_amount * pro_rated_fuel_charge) as pro_rated_calculated_carbon_tax
from fuel;

commit;
