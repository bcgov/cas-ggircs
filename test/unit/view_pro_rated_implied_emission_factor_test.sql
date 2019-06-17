set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

-- View should exist
select has_view(
    'ggircs', 'pro_rated_implied_emission_factor',
    'ggircs.pro_rated_implied_emission_factor should be a view'
);

-- Columns are correct
select columns_are('ggircs'::name, 'pro_rated_implied_emission_factor'::name, array[
    'reporting_year'::name,
    'fuel_type'::name,
    'fuel_mapping_id'::name,
    'year_length'::name,
    'start_rate'::name,
    'start_duration'::name,
    'end_rate'::name,
    'end_duration'::name,
    'pro_rated_implied_emission_factor'::name
]);

-- Column attributes are correct
select col_type_is('ggircs', 'pro_rated_implied_emission_factor', 'reporting_year', 'integer', 'pro_rated_implied_emission_factor.reporting_year column should be type integer');
select col_hasnt_default('ggircs', 'pro_rated_implied_emission_factor', 'reporting_year', 'pro_rated_implied_emission_factor.reporting_year column should not have a default value');

select col_type_is('ggircs', 'pro_rated_implied_emission_factor', 'fuel_type', 'character varying(1000)', 'pro_rated_implied_emission_factor.fuel_type column should be type character varying(1000)');
select col_hasnt_default('ggircs', 'pro_rated_implied_emission_factor', 'fuel_type', 'pro_rated_implied_emission_factor.fuel_type column should not have a default value');

select col_type_is('ggircs', 'pro_rated_implied_emission_factor', 'fuel_mapping_id', 'integer', 'pro_rated_implied_emission_factor.reporting_year column should be type integer');
select col_hasnt_default('ggircs', 'pro_rated_implied_emission_factor', 'fuel_mapping_id', 'pro_rated_implied_emission_factor.reporting_year column should not have a default value');

select col_type_is('ggircs', 'pro_rated_implied_emission_factor', 'year_length', 'integer', 'pro_rated_implied_emission_factor.year_length column should be type integer');
select col_hasnt_default('ggircs', 'pro_rated_implied_emission_factor', 'year_length', 'pro_rated_implied_emission_factor.year_length column should not have a default value');

select col_type_is('ggircs', 'pro_rated_implied_emission_factor', 'start_rate', 'numeric', 'pro_rated_implied_emission_factor.start_rate column should be type numeric');
select col_hasnt_default('ggircs', 'pro_rated_implied_emission_factor', 'start_rate', 'pro_rated_implied_emission_factor.start_rate column should not have a default value');

select col_type_is('ggircs', 'pro_rated_implied_emission_factor', 'start_duration', 'integer', 'pro_rated_implied_emission_factor.start_duration column should be type integer');
select col_hasnt_default('ggircs', 'pro_rated_implied_emission_factor', 'start_duration', 'pro_rated_implied_emission_factor.start_duration column should not have a default value');

select col_type_is('ggircs', 'pro_rated_implied_emission_factor', 'end_rate', 'numeric', 'pro_rated_implied_emission_factor.end_rate column should be type numeric');
select col_hasnt_default('ggircs', 'pro_rated_implied_emission_factor', 'end_rate', 'pro_rated_implied_emission_factor.end_rate column should not have a default value');

select col_type_is('ggircs', 'pro_rated_implied_emission_factor', 'end_duration', 'integer', 'pro_rated_implied_emission_factor.end_duration column should be type integer');
select col_hasnt_default('ggircs', 'pro_rated_implied_emission_factor', 'end_duration', 'pro_rated_implied_emission_factor.end_duration column should not have a default value');

select col_type_is('ggircs', 'pro_rated_implied_emission_factor', 'pro_rated_implied_emission_factor', 'numeric', 'pro_rated_implied_emission_factor.pro_rated_implied_emission_factor column should be type numeric');
select col_hasnt_default('ggircs', 'pro_rated_implied_emission_factor', 'pro_rated_implied_emission_factor', 'pro_rated_implied_emission_factor.pro_rated_implied_emission_factor column should not have a default value');

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

refresh materialized view ggircs_swrs.report with data;
refresh materialized view ggircs_swrs.fuel with data;


-- REPORT
    insert into ggircs.report (id, ghgr_import_id, source_xml, imported_at, swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
                               reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment)

    select id, ghgr_import_id, source_xml, imported_at, swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
           reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment

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

select results_eq(
    'select reporting_year from ggircs.pro_rated_implied_emission_factor order by reporting_year',

    $$
    select reporting_period_duration::integer
    from ggircs.fuel as fuel
    join ggircs.report as report
    on fuel.report_id = report.id
    order by reporting_period_duration
    $$,

    'pro_rated_implied_emission_factor properly selects the reporting year'
);

select set_eq(
    'select fuel_mapping_id from ggircs.pro_rated_implied_emission_factor order by fuel_mapping_id',

    $$
    select fm.id
    from ggircs.fuel as fuel
    join ggircs_swrs.fuel_mapping as fm
    on fuel.fuel_type = fm.fuel_type
    $$,

    'pro_rated_implied_emission_factor properly selects the fuel_mapping_id for the given fuel'
);

select results_eq(
    $$ select year_length from ggircs.pro_rated_implied_emission_factor where fuel_type != 'Wood Waste' order by year_length $$,

    ARRAY[364,365],

    'pro_rated_implied_emission_factor properly selects the length of the reporting year in days'
);

select results_eq(
    $$ select start_rate from ggircs.pro_rated_implied_emission_factor order by start_rate $$,

    ARRAY[0.315, 0.315, null, null],

    'pro_rated_implied_emission_factor properly selects the rate for the beginning of the year before the rate hike'
);

select results_eq(
    $$ select start_duration from ggircs.pro_rated_implied_emission_factor order by start_duration $$,

    ARRAY[90, 90, 91, 91],

    'pro_rated_implied_emission_factor properly selects the length of year before the rate hike'
);

select results_eq(
    $$ select end_duration from ggircs.pro_rated_implied_emission_factor order by end_duration $$,

    ARRAY[274, 274, 274, 274],

    'pro_rated_implied_emission_factor properly selects the length of year after the rate hike'
);

select results_eq(
    $$ select pro_rated_implied_emission_factor from ggircs.pro_rated_implied_emission_factor order by pro_rated_implied_emission_factor $$,

    $$
    select ((y.start_rate * y.start_duration) + (y.end_rate * y.end_duration)) / y.year_length as pro_rated_implied_emission_factor
    from ggircs.pro_rated_implied_emission_factor y
    order by pro_rated_implied_emission_factor
    $$,

    'pro_rated_implied_emission_factor properly pro-rates the implied emission factor'
);

select * from finish();
rollback;
