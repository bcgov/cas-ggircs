set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

-- View should exist
select has_view(
    'swrs', 'carbon_tax_calculation',
    'swrs.carbon_tax_calculation should be a view'
);

-- Columns are correct
select columns_are('swrs'::name, 'carbon_tax_calculation'::name, array[
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
    'unit_conversion_factor'::name,
    'flat_calculation'::name,
    'calculated_carbon_tax'::name
]);

-- Column attributes are correct
select col_type_is('swrs', 'carbon_tax_calculation', 'organisation_id', 'integer', 'carbon_tax_calculation.organisation_id column should be type integer');
select col_hasnt_default('swrs', 'carbon_tax_calculation', 'organisation_id', 'carbon_tax_calculation.organisation_id column should not have a default value');

select col_type_is('swrs', 'carbon_tax_calculation', 'facility_id', 'integer', 'carbon_tax_calculation.facility_id column should be type integer');
select col_hasnt_default('swrs', 'carbon_tax_calculation', 'facility_id', 'carbon_tax_calculation.facility_id column should not have a default value');

select col_type_is('swrs', 'carbon_tax_calculation', 'naics_id', 'integer', 'carbon_tax_calculation.naics_id column should be type integer');
select col_hasnt_default('swrs', 'carbon_tax_calculation', 'naics_id', 'carbon_tax_calculation.naics_id column should not have a default value');

select col_type_is('swrs', 'carbon_tax_calculation', 'year', 'integer', 'carbon_tax_calculation.reporting_year column should be type integer');
select col_hasnt_default('swrs', 'carbon_tax_calculation', 'year', 'carbon_tax_calculation.reporting_year column should not have a default value');

select col_type_is('swrs', 'carbon_tax_calculation', 'fuel_type', 'character varying(1000)', 'carbon_tax_calculation.fuel_type column should be type varchar');
select col_hasnt_default('swrs', 'carbon_tax_calculation', 'fuel_type', 'carbon_tax_calculation.fuel_type column should not have a default value');

select col_type_is('swrs', 'carbon_tax_calculation', 'fuel_amount', 'numeric', 'carbon_tax_calculation.fuel_amount column should be type numeric');
select col_hasnt_default('swrs', 'carbon_tax_calculation', 'fuel_amount', 'carbon_tax_calculation.fuel_amount column should not have a default value');

select col_type_is('swrs', 'carbon_tax_calculation', 'fuel_charge', 'numeric', 'carbon_tax_calculation.fuel_charge column should be type numeric');
select col_hasnt_default('swrs', 'carbon_tax_calculation', 'fuel_charge', 'carbon_tax_calculation.fuel_charge column should not have a default value');

select col_type_is('swrs', 'carbon_tax_calculation', 'unit_conversion_factor', 'integer', 'carbon_tax_calculation.unit_conversion_factor column should be type integer');
select col_hasnt_default('swrs', 'carbon_tax_calculation', 'unit_conversion_factor', 'carbon_tax_calculation.unit_conversion_factor column should not have a default value');

select col_type_is('swrs', 'carbon_tax_calculation', 'flat_calculation', 'character varying(1000)', 'carbon_tax_calculation.flat_calculation column should be type varchar');
select col_hasnt_default('swrs', 'carbon_tax_calculation', 'flat_calculation', 'carbon_tax_calculation.flat_calculation column should not have a default value');

select col_type_is('swrs', 'carbon_tax_calculation', 'calculated_carbon_tax', 'numeric', 'carbon_tax_calculation.calculated_carbon_tax column should be type numeric');
select col_hasnt_default('swrs', 'carbon_tax_calculation', 'calculated_carbon_tax', 'carbon_tax_calculation.calculated_carbon_tax column should not have a default value');

-- XML fixture for testing
insert into swrs_extract.eccc_xml_file (xml_file) values ($$
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
      <Process ProcessName="OGExtractionProcessing">
          <SubProcess SubprocessName="Flaring" InformationRequirement="Required">
              <Units>
                  <Unit>
                      <Fuels>
                          <Fuel>
                              <Emissions EmissionsType="Onshore Petroleum and NG Production: Well Testing Flaring">
                                  <Emission>
                                      <Groups>
                                          <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                                          <EmissionGroupTypes>BC_ScheduleB_FlaringEmissions</EmissionGroupTypes>
                                          <EmissionGroupTypes>EC_FlaringEmissions</EmissionGroupTypes>
                                      </Groups>
                                      <NotApplicable>true</NotApplicable>
                                      <Quantity>10</Quantity>
                                      <CalculatedQuantity>10</CalculatedQuantity>
                                      <GasType>CH4</GasType>
                                  </Emission>
                              </Emissions>
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

-- Run table export function without clearing the materialized views (for data equality tests below)
SET client_min_messages TO WARNING; -- load is a bit verbose
select swrs_transform.load(true, false);

-- Test fk relations
-- Organisation
select results_eq(
    $$ select organisation.swrs_organisation_id from swrs.carbon_tax_calculation as ct
       join swrs.organisation on ct.organisation_id = organisation.id
       and ct.fuel_type='Residual Fuel Oil (#5 & 6)'
    $$,
    'select swrs_organisation_id from swrs.organisation',
    'fk organisation_id references organisation'
);

-- Facility
select set_eq(
    $$ select facility.swrs_facility_id from swrs.carbon_tax_calculation as ct
       join swrs.facility on ct.facility_id = facility.id
       and ct.fuel_type='Residual Fuel Oil (#5 & 6)'
    $$,
    'select swrs_facility_id from swrs.facility',
    'fk facility_id references facility'
);

-- Naics
select set_eq(
    $$ select naics.naics_code from swrs.carbon_tax_calculation as ct
       join swrs.naics on ct.naics_id = naics.id
       and ct.fuel_type='Residual Fuel Oil (#5 & 6)'
    $$,
    'select naics_code from swrs.naics',
    'fk naics_id references naics'
);

-- Test validity of calculation
select results_eq(
    $$
      select calculated_carbon_tax from swrs.carbon_tax_calculation
      where fuel_type='Residual Fuel Oil (#5 & 6)'
      order by calculated_carbon_tax
    $$,

    $$
      with x as (
          select (fuel_charge * unit_conversion_factor) as flat_rate
          from swrs.fuel f
          join swrs.report r on f.report_id = r.id
          join swrs.fuel_mapping fm
          on f.fuel_mapping_id = fm.id
          join swrs.fuel_carbon_tax_details ctd
          on fm.fuel_carbon_tax_details_id = ctd.id
          join swrs.carbon_tax_act_fuel_type cta
          on ctd.carbon_tax_act_fuel_type_id = cta.id
          join swrs.fuel_charge fc
          on fc.carbon_tax_act_fuel_type_id = cta.id
          and f.fuel_type = 'Residual Fuel Oil (#5 & 6)'
          and concat(r.reporting_period_duration::text, '-12-31')::date between fc.start_date and fc.end_date
      )
      select x.flat_rate * (select annual_fuel_amount from swrs.fuel where fuel_type = 'Residual Fuel Oil (#5 & 6)') from x
    $$,

    'swrs.carbon_tax_calculation properly calculates carbon tax based on fuel_amount'
);

select * from finish();
rollback;
