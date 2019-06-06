set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

-- View should exist
select has_view(
    'ggircs', 'carbon_tax_calculation',
    'ggircs.carbon_tax_calculation should be a view'
);

-- Columns are correct
select columns_are('ggircs'::name, 'carbon_tax_calculation'::name, array[
    'year'::name,
    'fuel_type'::name,
    'calculated_carbon_tax'::name
]);

-- Column attributes are correct
select col_type_is('ggircs', 'carbon_tax_calculation', 'year', 'integer', 'pro_rated_carbon_tax_rate.reporting_year column should be type integer');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'year', 'pro_rated_carbon_tax_rate.reporting_year column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'fuel_type', 'character varying(1000)', 'pro_rated_carbon_tax_rate.fuel_type column should be type varchar');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'fuel_type', 'pro_rated_carbon_tax_rate.fuel_type column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'calculated_carbon_tax', 'numeric', 'pro_rated_carbon_tax_rate.calculated_carbon_tax column should be type numeric');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'calculated_carbon_tax', 'pro_rated_carbon_tax_rate.calculated_carbon_tax column should not have a default value');

-- XML fixture for testing
insert into ggircs_swrs.ghgr_import (xml_file) values ($$<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ReportDetails>
    <ReportID>1234</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0000</FacilityId>
    <FacilityType>EIO</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2025</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Submitted</Status>
      <SubmissionDate>2013-03-27T19:25:55.32</SubmissionDate>
      <LastModifiedBy>Buddy</LastModifiedBy>
    </ReportStatus>
  </ReportDetails>
  <ActivityData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ActivityPages>
      <Process ProcessName="ElectricityGeneration">
        <SubProcess SubprocessName="Emissions from fuel combustion for electricity generation" InformationRequirement="Required">
          <Units UnitType="Cogen Units">
            <Unit>
              <Fuels>
                <Fuel>
                  <FuelType>Wood Waste</FuelType>
                  <FuelClassification>Biomass in Schedule C</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>bone dry tonnes</FuelUnits>
                  <AnnualFuelAmount>0</AnnualFuelAmount>
                  <AnnualSteamGeneration>290471000</AnnualSteamGeneration>
                </Fuel>
                <Fuel>
                  <FuelType>Residual Fuel Oil (#5 &amp; 6)</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>kilolitres</FuelUnits>
                  <AnnualFuelAmount>9441</AnnualFuelAmount>
                  <AnnualWeightedAverageCarbonContent>0.862</AnnualWeightedAverageCarbonContent>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
      </Process>
    </ActivityPages>
  </ActivityData>
</ReportData>
$$), ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ReportDetails>
    <ReportID>1235</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0001</FacilityId>
    <FacilityType>ABC</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2020</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Submitted</Status>
      <SubmissionDate>2013-03-28T19:25:55.32</SubmissionDate>
      <LastModifiedBy>Buddy</LastModifiedBy>
    </ReportStatus>
  </ReportDetails>
  <ActivityData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ActivityPages>
      <Process ProcessName="ElectricityGeneration">
        <SubProcess SubprocessName="Emissions from fuel combustion for electricity generation" InformationRequirement="Required">
          <Units UnitType="Cogen Units">
            <Unit>
              <Fuels>
                <Fuel>
                  <FuelType>Wood Waste</FuelType>
                  <FuelClassification>Biomass in Schedule C</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>bone dry tonnes</FuelUnits>
                  <AnnualFuelAmount>0</AnnualFuelAmount>
                  <AnnualSteamGeneration>290471000</AnnualSteamGeneration>
                </Fuel>
                <Fuel>
                  <FuelType>Residual Fuel Oil (#5 &amp; 6)</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>kilolitres</FuelUnits>
                  <AnnualFuelAmount>9441</AnnualFuelAmount>
                  <AnnualWeightedAverageCarbonContent>0.862</AnnualWeightedAverageCarbonContent>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
      </Process>
    </ActivityPages>
  </ActivityData>
</ReportData>
$$);

-- Refresh necessary materialized views
refresh materialized view ggircs_swrs.report with data;
refresh materialized view ggircs_swrs.fuel with data;

-- Populate necessary ggircs tables

-- REPORT
    insert into ggircs.report (id, ghgr_import_id, source_xml, imported_at, swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
                               reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment, swrs_report_history_id)

    select id, ghgr_import_id, source_xml, imported_at, swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
           reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment, swrs_report_history_id

    from ggircs_swrs.report;

-- FUEL
    insert into ggircs.fuel(id, ghgr_import_id, report_id,
                            activity_name, sub_activity_name, unit_name, sub_unit_name, fuel_type, fuel_classification, fuel_description,
                            fuel_units, annual_fuel_amount, annual_weighted_avg_carbon_content, annual_weighted_avg_hhv, annual_steam_generation, alternative_methodology_description,
                            other_flare_details, q1, q2, q3, q4, wastewater_processing_factors, measured_conversion_factors)

    select _fuel.id, _fuel.ghgr_import_id, _report.id,
           _fuel.activity_name, _fuel.sub_activity_name, _fuel.unit_name, _fuel.sub_unit_name, _fuel.fuel_type, _fuel.fuel_classification, _fuel.fuel_description,
           _fuel.fuel_units, _fuel.annual_fuel_amount, _fuel.annual_weighted_avg_carbon_content, _fuel.annual_weighted_avg_hhv, _fuel.annual_steam_generation,
           _fuel.alternative_methodology_description, _fuel.other_flare_details, _fuel.q1, _fuel.q2, _fuel.q3, _fuel.q4, _fuel.wastewater_processing_factors, _fuel.measured_conversion_factors

    from ggircs_swrs.fuel
    left join ggircs_swrs.fuel as _fuel on _fuel.id = fuel.id
    -- FK Fuel -> Report
    left join ggircs_swrs.report as _report
    on _fuel.ghgr_import_id = _report.ghgr_import_id;

-- Test validity of calculation
select results_eq(
    'select calculated_carbon_tax from ggircs.carbon_tax_calculation',

    $$
    with x as (
        select fuel.fuel_type                           as fuel_type,
               fuel.annual_fuel_amount                  as amount,
               report.reporting_period_duration::integer         as rpd,
               pro_rated_carbon_tax_rate                as pro_rated_ctr,
               pro_rated_implied_emission_factor        as pro_rated_ief
        from ggircs.fuel
                join ggircs_swrs.fuel_mapping as fm
                    on fuel.fuel_type = fm.fuel_type
                join ggircs.report as report
                    on fuel.report_id = report.id
                join ggircs.pro_rated_carbon_tax_rate as ctr
                    on fuel.fuel_type = ctr.fuel_type
                    and report.reporting_period_duration::integer = ctr.reporting_year
                join ggircs.pro_rated_implied_emission_factor as ief
                    on ief.fuel_mapping_id = fm.id
                    and report.reporting_period_duration::integer = ief.reporting_year

    )
    select
      (x.amount * x.pro_rated_ctr * x.pro_rated_ief) as calculated_carbon_tax
    from x
    $$,

    'ggircs.carbon_tax_calculation properly calculates carbon tax based on fuel_amount * pro-rated carbon tax rate * pro-rated implied emission factor'
);

select * from finish();
rollback;
