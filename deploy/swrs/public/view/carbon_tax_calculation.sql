-- Deploy ggircs:view_carbon_tax_calculation to pg
-- requires:
    -- schema_ggircs
    -- table_fuel
    -- table_report

begin;

drop view swrs.carbon_tax_calculation;

-- Column unit_conversion_factor should be numeric, not integer.
-- Change must be done immediately after dropping the view since the view relies on the column
alter table swrs.fuel_carbon_tax_details alter column unit_conversion_factor type numeric;

create or replace view swrs.carbon_tax_calculation as
  with fuel_data as (

    -- FLARED EMISSION
    select e.report_id, 'Natural Gas (Sm^3)' as fuel_type, e.fuel_mapping_id, fm.fuel_carbon_tax_details_id, ctd.carbon_tax_act_fuel_type_id, (coalesce(e.quantity, 0::numeric) * ctd.unit_conversion_factor::numeric) as fuel_amount
        from swrs.emission e
        join swrs.fuel_mapping fm
          on e.fuel_mapping_id = fm.id
          and e.fuel_mapping_id = 145
        join swrs.fuel_carbon_tax_details ctd
          on fm.fuel_carbon_tax_details_id = ctd.id

    union

    -- VENTED EMISSION
    select e.report_id, 'Natural Gas (Sm^3)' as fuel_type, e.fuel_mapping_id, fm.fuel_carbon_tax_details_id, ctd.carbon_tax_act_fuel_type_id, (coalesce(e.quantity, 0::numeric) * ctd.unit_conversion_factor::numeric) as fuel_amount
        from swrs.emission e
        join swrs.fuel_mapping fm
          on e.fuel_mapping_id = fm.id
          and e.fuel_mapping_id = 148
        join swrs.fuel_carbon_tax_details ctd
          on fm.fuel_carbon_tax_details_id = ctd.id

    union

    -- FUEL
    select f.report_id, ctd.normalized_fuel_type, f.fuel_mapping_id, fm.fuel_carbon_tax_details_id, ctd.carbon_tax_act_fuel_type_id, (coalesce(f.annual_fuel_amount, 0::numeric) * ctd.unit_conversion_factor::numeric) as fuel_amount
        from swrs.fuel f
        join swrs.fuel_mapping fm
          on f.fuel_mapping_id = fm.id
        join swrs.fuel_carbon_tax_details ctd
          on fm.fuel_carbon_tax_details_id = ctd.id

    )
    select fd.*, r.reporting_period_duration, _fuel_charge.fuel_charge, round((fuel_amount * _fuel_charge.fuel_charge), 2) as calculated_carbon_tax from fuel_data fd
    join swrs.report r
        on r.id = fd.report_id
    join swrs.facility as _facility
        on r.id = _facility.report_id
        and _facility.facility_type != 'LFO'
    join swrs.carbon_tax_act_fuel_type as _cta
      on carbon_tax_act_fuel_type_id = _cta.id
    join swrs.fuel_charge as _fuel_charge
      on _fuel_charge.carbon_tax_act_fuel_type_id = _cta.id
      and (concat(r.reporting_period_duration::text, '-12-31')::date
      between _fuel_charge.start_date and _fuel_charge.end_date);

commit;
