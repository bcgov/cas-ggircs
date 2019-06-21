-- Deploy ggircs:view_carbon_tax_calculation to pg
-- requires:
    -- schema_ggircs
    -- table_fuel
    -- table_report

begin;

create or replace view ggircs.carbon_tax_calculation as
    with fuel as (
        select _organisation.id                                              as organisation_id,
               _single_facility.id                                           as single_facility_id,
               _naics.id                                                     as naics_id,
               _fuel_mapping.fuel_type,
               coalesce(_fuel.annual_fuel_amount, _emission.quantity)        as fuel_amount,
               _report.reporting_period_duration::integer as year,
               _pro_rated_fuel_charge.pro_rated_fuel_charge
        from ggircs.fuel as _fuel
                 join ggircs_swrs.fuel_mapping as _fuel_mapping
                      on _fuel.fuel_type = _fuel_mapping.fuel_type
                 join ggircs.report as _report
                      on _fuel.report_id = _report.id
                 left join ggircs.organisation as _organisation
                      on _report.id = _organisation.report_id
                 inner join ggircs.single_facility as _single_facility
                      on _report.id = _single_facility.report_id
                 left join ggircs.naics as _naics
                      on _report.id = _naics.report_id
                      and _naics.path_context = 'Registration_Data'
                 join ggircs.pro_rated_fuel_charge as _pro_rated_fuel_charge
                      on _fuel_mapping.id = _pro_rated_fuel_charge.fuel_mapping_id
                      and _report.reporting_period_duration::integer = _pro_rated_fuel_charge.rpd
                 left join ggircs.emission as _emission
                      on _fuel_mapping.id = _emission.fuel_mapping_id
    )
select fuel.organisation_id,
       fuel.single_facility_id,
       fuel.naics_id,
       fuel.year,
       fuel.fuel_type,
       fuel.fuel_amount,
       (fuel.fuel_amount * pro_rated_fuel_charge) as calculated_carbon_tax
from fuel;

commit;
