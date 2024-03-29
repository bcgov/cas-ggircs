set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(7);

-- View should exist
select has_view(
    'swrs', 'carbon_tax_calculation',
    'swrs.carbon_tax_calculation should be a view'
);

-- Columns are correct
select columns_are('swrs'::name, 'carbon_tax_calculation'::name, array[
    'report_id'::name,
    'fuel_mapping_id'::name,
    'fuel_carbon_tax_detail_id'::name,
    'carbon_tax_act_fuel_type_id'::name,
    'facility_id'::name,
    'facility_name'::name,
    'fuel_type'::name,
    'fuel_amount'::name,
    'fuel_charge'::name,
    'calculated_carbon_tax'::name,
    'emission_category'::name
]);

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
                  <AnnualFuelAmount>12</AnnualFuelAmount>
                  <AnnualSteamGeneration>290471000</AnnualSteamGeneration>
                  <Emissions>
                    <Emission>
                        <Groups>
                            <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        </Groups>
                        <NotApplicable>true</NotApplicable>
                        <Quantity>10</Quantity>
                        <CalculatedQuantity>10</CalculatedQuantity>
                        <GasType>CO2</GasType>
                    </Emission>
                </Emissions>
                </Fuel>
                <Fuel>
                  <FuelType>Residual Fuel Oil (#5 &amp; 6)</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>kilolitres</FuelUnits>
                  <AnnualFuelAmount>9441</AnnualFuelAmount>
                  <AnnualWeightedAverageCarbonContent>0.862</AnnualWeightedAverageCarbonContent>
                  <Emissions>
                    <Emission>
                        <Groups>
                            <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        </Groups>
                        <NotApplicable>true</NotApplicable>
                        <Quantity>10</Quantity>
                        <CalculatedQuantity>10</CalculatedQuantity>
                        <GasType>CO2</GasType>
                    </Emission>
                </Emissions>
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
                                      <GasType>CO2</GasType>
                                  </Emission>
                              </Emissions>
                          </Fuel>
                      </Fuels>
                  </Unit>
              </Units>
          </SubProcess>
      </Process>
      <Process ProcessName="OGExtractionProcessing">
          <SubProcess SubprocessName="Venting" InformationRequirement="Required">
              <Units>
                  <Unit>
                      <Fuels>
                          <Fuel>
                              <Emissions EmissionsType="NG Distribution: NG continuous high bleed devices venting">
                                  <Emission>
                                      <Groups>
                                          <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                                          <EmissionGroupTypes>BC_ScheduleB_VentingEmissions</EmissionGroupTypes>
                                          <EmissionGroupTypes>EC_VentingEmissions</EmissionGroupTypes>
                                      </Groups>
                                      <NotApplicable>true</NotApplicable>
                                      <Quantity>10</Quantity>
                                      <CalculatedQuantity>10</CalculatedQuantity>
                                      <GasType>CH4</GasType>
                                  </Emission>
                                  <Emission>
                                      <Groups>
                                          <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                                          <EmissionGroupTypes>BC_ScheduleB_VentingEmissions</EmissionGroupTypes>
                                          <EmissionGroupTypes>EC_VentingEmissions</EmissionGroupTypes>
                                      </Groups>
                                      <NotApplicable>true</NotApplicable>
                                      <Quantity>1000</Quantity>
                                      <CalculatedQuantity>10</CalculatedQuantity>
                                      <GasType>CO2</GasType>
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

-- Test validity of calculation
select results_eq(
    $$
      select calculated_carbon_tax from swrs.carbon_tax_calculation
      where fuel_type='Residual Fuel Oil (#5 & 6) (kilolitres)'
      order by calculated_carbon_tax
    $$,

    $$
      with x as (
          select (fuel_charge * unit_conversion_factor) as flat_rate
          from swrs.fuel f
          join swrs.report r on f.report_id = r.id
          join ggircs_parameters.fuel_mapping fm
          on f.fuel_mapping_id = fm.id
          join ggircs_parameters.fuel_carbon_tax_detail ctd
          on fm.fuel_carbon_tax_detail_id = ctd.id
          join ggircs_parameters.carbon_tax_act_fuel_type cta
          on ctd.carbon_tax_act_fuel_type_id = cta.id
          join ggircs_parameters.fuel_charge fc
          on fc.carbon_tax_act_fuel_type_id = cta.id
          and f.fuel_type = 'Residual Fuel Oil (#5 & 6)'
          and concat(r.reporting_period_duration::text, '-12-31')::date between fc.start_date and fc.end_date
      )
      select x.flat_rate * (select annual_fuel_amount from swrs.fuel where fuel_type = 'Residual Fuel Oil (#5 & 6)') from x
    $$,

    'swrs.carbon_tax_calculation properly calculates carbon tax based on fuel_amount'
);

select is_empty(
    $$
      select calculated_carbon_tax from swrs.carbon_tax_calculation
      where fuel_type='Wood Waste'
    $$,
    'swrs.carbon_tax_calculation does not calculate carbon tax for Fuels in non-carbon taxed emission categories'
);

select results_eq(
    $$
      select calculated_carbon_tax from swrs.carbon_tax_calculation
      where fuel_type='Natural Gas (Sm^3)'
      and emission_category='BC_ScheduleB_FlaringEmissions';
    $$,

    $$
      select round((10 * (1000000 / 2151.0) * 0.057), 2);
    $$,

    'The carbon tax calculator properly calculates the tax for Flaring emissions:
      Given the quantity of 10 tonnes of Flared CO2, and a fuel charge for Natural Gas of 0.057 (for reporting year 2015)
      We apply a modifier of 1000 to convert tonnes to kg: 10 * 1000 = 10000kg CO2
      Then apply the kg/m3 ratio: 10000 / 2.151 = 464900.05 (we now have a Natural Gas fuel amount here)
      The NG fuel amount would be multiplied by its fuel_charge for that year: 464900.04 * 0.057 = 264.99 CAD'
);


select results_eq(
    $$
      select calculated_carbon_tax from swrs.carbon_tax_calculation
      where fuel_type='Natural Gas (Sm^3)'
      and emission_category='BC_ScheduleB_VentingEmissions';
    $$,

    $$
      select round((10 * (1000000 / 678.5) * 0.057), 2);
    $$,

    'The carbon tax calculator properly calculates the tax for Venting emissions:
      Given the quantity of 10 tonnes of Vented CH4, and a fuel charge for Natural Gas of 0.057 (for reporting year 2015)
      We apply a modifier of 1000 to convert tonnes to kg: 10 * 1000 = 10000kg CH4
      Then apply the kg/m3 ratio: 10000 / 0.6785 = 1473839.35 (we now have a Natural Gas fuel amount here)
      The NG fuel amount would be multiplied by its fuel_charge for that year: 1473839.35 * 0.057 = 840.09 CAD'
);

select is(
    (select gas_type from swrs.emission where fuel_mapping_id = (select id from ggircs_parameters.fuel_mapping where fuel_type = 'Vented Natural Gas CH4')),
    'CH4'::varchar,
    'swrs.carbon_tax_calculation only considers the gas_type CH4 when calculating vented emissions'
);

select * from finish();
rollback;
