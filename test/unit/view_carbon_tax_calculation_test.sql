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
    'report_id'::name,
    'organisation_id'::name,
    'facility_id'::name,
    'naics_id'::name,
    'activity_id'::name,
    'fuel_id'::name,
    'emission_id'::name,
    'year'::name,
    'fuel_type'::name,
    'fuel_amount'::name,
    'fuel_charge'::name,
    'pro_rated_fuel_charge'::name,
    'unit_conversion_factor'::name,
    'flat_calculation'::name,
    'pro_rated_calculation'::name,
    'calculated_carbon_tax'::name,
    'pro_rated_calculated_carbon_tax'::name
]);

-- Column attributes are correct
select col_type_is('ggircs', 'carbon_tax_calculation', 'organisation_id', 'integer', 'carbon_tax_calculation.organisation_id column should be type integer');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'organisation_id', 'carbon_tax_calculation.organisation_id column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'facility_id', 'integer', 'carbon_tax_calculation.facility_id column should be type integer');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'facility_id', 'carbon_tax_calculation.facility_id column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'naics_id', 'integer', 'carbon_tax_calculation.naics_id column should be type integer');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'naics_id', 'carbon_tax_calculation.naics_id column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'year', 'integer', 'carbon_tax_calculation.reporting_year column should be type integer');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'year', 'carbon_tax_calculation.reporting_year column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'fuel_type', 'character varying(1000)', 'carbon_tax_calculation.fuel_type column should be type varchar');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'fuel_type', 'carbon_tax_calculation.fuel_type column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'fuel_amount', 'numeric', 'carbon_tax_calculation.fuel_amount column should be type numeric');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'fuel_amount', 'carbon_tax_calculation.fuel_amount column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'fuel_charge', 'numeric', 'carbon_tax_calculation.fuel_charge column should be type numeric');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'fuel_charge', 'carbon_tax_calculation.fuel_charge column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'pro_rated_fuel_charge', 'numeric', 'carbon_tax_calculation.pro_rated_fuel_charge column should be type numeric');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'pro_rated_fuel_charge', 'carbon_tax_calculation.pro_rated_fuel_charge column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'unit_conversion_factor', 'integer', 'carbon_tax_calculation.unit_conversion_factor column should be type integer');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'unit_conversion_factor', 'carbon_tax_calculation.unit_conversion_factor column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'flat_calculation', 'character varying(1000)', 'carbon_tax_calculation.flat_calculation column should be type varchar');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'flat_calculation', 'carbon_tax_calculation.flat_calculation column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'pro_rated_calculation', 'character varying(1000)', 'carbon_tax_calculation.pro_rated_calculation column should be type varchar');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'pro_rated_calculation', 'carbon_tax_calculation.pro_rated_calculation column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'calculated_carbon_tax', 'numeric', 'carbon_tax_calculation.calculated_carbon_tax column should be type numeric');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'calculated_carbon_tax', 'carbon_tax_calculation.calculated_carbon_tax column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'pro_rated_calculated_carbon_tax', 'numeric', 'carbon_tax_calculation.pro_rated_calculated_carbon_tax column should be type numeric');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'pro_rated_calculated_carbon_tax', 'carbon_tax_calculation.pro_rated_calculated_carbon_tax column should not have a default value');

-- XML fixture for testing
insert into ggircs_swrs_extract.ghgr_import (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
  <Facility>
  </Facility>
    <NAICSCodeList>
      <NAICSCode>
        <NAICSClassification>Chemical Pulp Mills </NAICSClassification>
        <Code>322112</Code>
        <NaicsPriority>Primary</NaicsPriority>
      </NAICSCode>
    </NAICSCodeList>
  </RegistrationData>
  <ReportDetails>
    <ReportID>123500000</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0001</FacilityId>
    <FacilityType>ABC</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2015</ReportingPeriodDuration>
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
                  <Emissions><Emission></Emission></Emissions>
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
refresh materialized view ggircs_swrs_transform.report with data;
refresh materialized view ggircs_swrs_transform.final_report with data;
refresh materialized view ggircs_swrs_transform.organisation with data;
refresh materialized view ggircs_swrs_transform.facility with data;
refresh materialized view ggircs_swrs_transform.activity with data;
refresh materialized view ggircs_swrs_transform.unit with data;
refresh materialized view ggircs_swrs_transform.identifier with data;
refresh materialized view ggircs_swrs_transform.naics with data;
refresh materialized view ggircs_swrs_transform.fuel with data;
refresh materialized view ggircs_swrs_transform.emission with data;

-- Populate necessary ggircs tables
select ggircs_swrs_transform.load_report();
select ggircs_swrs_transform.load_organisation();
select ggircs_swrs_transform.load_facility();
select ggircs_swrs_transform.load_activity();
select ggircs_swrs_transform.load_unit();
select ggircs_swrs_transform.load_identifier();
select ggircs_swrs_transform.load_naics();
select ggircs_swrs_transform.load_fuel();
select ggircs_swrs_transform.load_emission();

-- Test fk relations
-- Organisation
select results_eq(
    $$ select organisation.swrs_organisation_id from ggircs.carbon_tax_calculation as ct
       join ggircs.organisation on ct.organisation_id = organisation.id
    $$,
    'select swrs_organisation_id from ggircs.organisation',
    'fk organisation_id references organisation'
);

-- Facility
select set_eq(
    $$ select facility.swrs_facility_id from ggircs.carbon_tax_calculation as ct
       join ggircs.facility on ct.facility_id = facility.id
    $$,
    'select swrs_facility_id from ggircs.facility',
    'fk facility_id references facility'
);

-- Naics
select set_eq(
    $$ select naics.naics_code from ggircs.carbon_tax_calculation as ct
       join ggircs.naics on ct.naics_id = naics.id
    $$,
    'select naics_code from ggircs.naics',
    'fk naics_id references naics'
);

-- Test validity of calculation
select results_eq(
    'select calculated_carbon_tax from ggircs.carbon_tax_calculation order by calculated_carbon_tax',

    $$
      with x as (
        select flat_rate from ggircs.pro_rated_fuel_charge where fuel_type = 'Residual Fuel Oil (#5 & 6)'
      )
      select x.flat_rate * (select annual_fuel_amount from ggircs.fuel where fuel_type = 'Residual Fuel Oil (#5 & 6)') from x
    $$,

    'ggircs.carbon_tax_calculation properly calculates carbon tax based on fuel_amount * pro-rated carbon tax rate * pro-rated implied emission factor'
);

select * from finish();
rollback;
