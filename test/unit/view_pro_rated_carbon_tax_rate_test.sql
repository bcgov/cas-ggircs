set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(18);

-- View should exist
select has_view(
    'ggircs', 'pro_rated_carbon_tax_rate',
    'ggircs.pro_rated_carbon_tax_rate should be a view'
);

-- Columns are correct
select columns_are('ggircs'::name, 'pro_rated_carbon_tax_rate'::name, array[
    'reporting_year'::name,
    'fuel_type'::name,
    'year_length'::name,
    'start_rate'::name,
    'start_duration'::name,
    'end_rate'::name,
    'end_duration'::name,
    'pro_rated_carbon_tax_rate'::name
]);

-- Column attributes are correct
select col_type_is('ggircs', 'pro_rated_carbon_tax_rate', 'reporting_year', 'integer', 'pro_rated_carbon_tax_rate.reporting_year column should be type integer');
select col_hasnt_default('ggircs', 'pro_rated_carbon_tax_rate', 'reporting_year', 'pro_rated_carbon_tax_rate.reporting_year column should not have a default value');

select col_type_is('ggircs', 'pro_rated_carbon_tax_rate', 'fuel_type', 'character varying(1000)', 'pro_rated_carbon_tax_rate.fuel_type column should be type character varying(1000)');
select col_hasnt_default('ggircs', 'pro_rated_carbon_tax_rate', 'fuel_type', 'pro_rated_carbon_tax_rate.fuel_type column should not have a default value');

select col_type_is('ggircs', 'pro_rated_carbon_tax_rate', 'year_length', 'integer', 'pro_rated_carbon_tax_rate.year_length column should be type integer');
select col_hasnt_default('ggircs', 'pro_rated_carbon_tax_rate', 'year_length', 'pro_rated_carbon_tax_rate.year_length column should not have a default value');

select col_type_is('ggircs', 'pro_rated_carbon_tax_rate', 'start_rate', 'numeric', 'pro_rated_carbon_tax_rate.start_rate column should be type numeric');
select col_hasnt_default('ggircs', 'pro_rated_carbon_tax_rate', 'start_rate', 'pro_rated_carbon_tax_rate.start_rate column should not have a default value');

select col_type_is('ggircs', 'pro_rated_carbon_tax_rate', 'start_duration', 'integer', 'pro_rated_carbon_tax_rate.start_duration column should be type integer');
select col_hasnt_default('ggircs', 'pro_rated_carbon_tax_rate', 'start_duration', 'pro_rated_carbon_tax_rate.start_duration column should not have a default value');

select col_type_is('ggircs', 'pro_rated_carbon_tax_rate', 'end_rate', 'numeric', 'pro_rated_carbon_tax_rate.end_rate column should be type numeric');
select col_hasnt_default('ggircs', 'pro_rated_carbon_tax_rate', 'end_rate', 'pro_rated_carbon_tax_rate.end_rate column should not have a default value');

select col_type_is('ggircs', 'pro_rated_carbon_tax_rate', 'end_duration', 'integer', 'pro_rated_carbon_tax_rate.end_duration column should be type integer');
select col_hasnt_default('ggircs', 'pro_rated_carbon_tax_rate', 'end_duration', 'pro_rated_carbon_tax_rate.end_duration column should not have a default value');

select col_type_is('ggircs', 'pro_rated_carbon_tax_rate', 'pro_rated_carbon_tax_rate', 'numeric', 'pro_rated_carbon_tax_rate.pro_rated_carbon_tax_rate column should be type numeric');
select col_hasnt_default('ggircs', 'pro_rated_carbon_tax_rate', 'pro_rated_carbon_tax_rate', 'pro_rated_carbon_tax_rate.pro_rated_carbon_tax_rate column should not have a default value');

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

select * from ggircs.pro_rated_carbon_tax_rate;

select * from finish();
rollback;
