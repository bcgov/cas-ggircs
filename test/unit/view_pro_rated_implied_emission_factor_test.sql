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

select results_eq(
    'select reporting_year from ggircs.pro_rated_implied_emission_factor order by reporting_year',

    $$
    select reporting_period_duration::integer
    from ggircs_swrs.fuel as fuel
    join ggircs_swrs.report as report
    on report.ghgr_import_id = fuel.ghgr_import_id
    order by reporting_period_duration
    $$,

    'pro_rated_implied_emission_factor properly selects the reporting year'
);

select results_eq(
    $$ select year_length from ggircs.pro_rated_implied_emission_factor where fuel_type = 'Wood Waste' $$,

    $$
    with x as (
    select reporting_period_duration as rpd, fuel_type
    from ggircs_swrs.fuel as fuel
    join ggircs_swrs.report as report
    on report.ghgr_import_id = fuel.ghgr_import_id
    )
    select concat((x.rpd)::text, '-12-31')::date - concat((x.rpd)::text, '-01-01')::date as year_length
    from x where x.fuel_type = 'Wood Waste'
    $$,

    'pro_rated_implied_emission_factor properly selects the length of the reporting year in days'
);

select results_eq(
    'select fuel_mapping_id from ggircs.pro_rated_implied_emission_factor order by fuel_mapping_id',

    $$
    select fm.id
    from ggircs_swrs.fuel as fuel
    join ggircs_swrs.fuel_mapping as fm
    on fuel.fuel_type = fm.fuel_type
    $$,

    'pro_rated_implied_emission_factor properly selects the fuel_mapping_id for the given fuel'
);

select results_eq(
    $$ select year_length from ggircs.pro_rated_implied_emission_factor where fuel_type = 'Wood Waste' $$,

    $$
    with x as (
    select reporting_period_duration as rpd, fuel_type
    from ggircs_swrs.fuel as fuel
    join ggircs_swrs.report as report
    on report.ghgr_import_id = fuel.ghgr_import_id
    )
    select concat((x.rpd::integer)::text, '-12-31')::date - concat((x.rpd::integer)::text, '-01-01')::date as year_length
    from x where x.fuel_type = 'Wood Waste'
    $$,

    'pro_rated_implied_emission_factor properly selects the length of the reporting year in days'
);

select results_eq(
    $$ select start_rate from ggircs.pro_rated_implied_emission_factor order by start_rate $$,

    ARRAY[0.315, 0.3151111111, null, null],

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
    select ((y.start_rate * y.start_duration) + (y.end_rate * y.end_duration)) / y.year_length as pro_rated_implied_emission_factor from ggircs.pro_rated_implied_emission_factor y
    $$,

    'pro_rated_implied_emission_factor properly pro-rates the implied emission factor'
);

select * from finish();
rollback;
