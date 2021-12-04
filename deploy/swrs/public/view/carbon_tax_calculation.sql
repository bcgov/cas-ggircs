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
        join swrs.emission_category ec
          on f.emission_category = ec.swrs_emission_category
          and ec.carbon_taxed=true

    )
    select fd.*, _facility.id as facility_id, _facility.facility_name, r.reporting_period_duration as reporting_year, _fuel_charge.fuel_charge, round((fuel_amount * _fuel_charge.fuel_charge), 2) as calculated_carbon_tax from fuel_data fd
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

comment on view swrs.carbon_tax_calculation is 'Calculates carbon tax for each fuel type based on the data in the Schedule 2 table found in the carbon tax act https://www.bclaws.gov.bc.ca/civix/document/id/complete/statreg/08040_01';
comment on column swrs.carbon_tax_calculation.report_id is 'The id of the report each fuel was reported for';
comment on column swrs.carbon_tax_calculation.fuel_type is 'The fuel type reported';
comment on column swrs.carbon_tax_calculation.fuel_mapping_id is 'The id to the the fuel mapping table matching the fuel type';
comment on column swrs.carbon_tax_calculation.fuel_carbon_tax_details_id is 'The id to the the fuel carbon tax details table matching the fuel type';
comment on column swrs.carbon_tax_calculation.carbon_tax_act_fuel_type_id is 'The id to the the carbon tax act fuel type table matching the fuel type, matches the Schedule 2 table in the carbon tax act https://www.bclaws.gov.bc.ca/civix/document/id/complete/statreg/08040_01';
comment on column swrs.carbon_tax_calculation.fuel_amount is $$
  The amount of fuel reported for the fuel type.
  This fuel_amount is the annual_fuel_amount as reported in swrs multiplied by the unit_conversion_factor in the fuel_carbon_tax_details table to normalize the units with the rate defined in the carbon tax.
  Vented and Flared emissions return a fuel_amount that has been converted to a natural gas fuel_amount of m3.
  X tonnes of Flared CO2 emissions return a record with a Natural gas fuel amount of Y (as per WCI.20 EF for non-marketable gas, Table 20-3: 2.151 kgCO2/m3 non-marketable NG in BC)
$$;
comment on column swrs.carbon_tax_calculation.facility_id is 'The id of the facility the fuel was reported for';
comment on column swrs.carbon_tax_calculation.reporting_year is 'The reporting year the fuel was reported';
comment on column swrs.carbon_tax_calculation.fuel_charge is 'The fuel charge applied to the fuel_type for the reporting year it was reported';
comment on column swrs.carbon_tax_calculation.calculated_carbon_tax is 'The calculated carbon tax for the reported fuel';

commit;
