set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

-- Test matview report exists in schema swrs_transform
select has_materialized_view('swrs_transform', 'historical_report_emission_data', 'Materialized view historical_report_emission_data exists');

-- Setup fixture
insert into swrs_extract.eccc_xml_file (imported_at, xml_file) VALUES ('2018-09-29T11:55:39.423', $$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ReportDetails>
    <ReportID>800855555</ReportID>
    <PrepopReportID></PrepopReportID>
    <ReportType>R7</ReportType>
    <FacilityId>666</FacilityId>
    <OrganisationId>1337</OrganisationId>
    <ReportingPeriodDuration>1999</ReportingPeriodDuration>
    <ReportStatus>
      <Status>In Progress</Status>
      <Version>3</Version>
      <LastModifiedBy>Donny Donaldson McDonaldface</LastModifiedBy>
      <LastModifiedDate>2018-09-28T11:55:39.423</LastModifiedDate>
    </ReportStatus>
  </ReportDetails>
  <ActivityData>
    <ActivityPages>
      <TotalEmissions>
        <TotalGroups TotalGroupType="TotalGHGEmissionGas">
          <Totals>
            <Emissions EmissionsGasType="GHGEmissionGas">
              <TotalRow>
                <Quantity>100</Quantity>
                <CalculatedQuantity>100</CalculatedQuantity>
                <GasType>CO2bioC</GasType>
                <GasGroupType>None</GasGroupType>
              </TotalRow>
              <TotalRow>
                <Quantity>0.00000000</Quantity>
                <CalculatedQuantity>0.00000000</CalculatedQuantity>
                <GasType>CO2bionC</GasType>
                <GasGroupType>None</GasGroupType>
              </TotalRow>
              <GrandTotal>
                <Total>300</Total>
              </GrandTotal>
            </Emissions>
          </Totals>
        </TotalGroups>
        <TotalGroups TotalGroupType="ReportingOnlyEmissions">
          <Totals>
            <Emissions EmissionsGasType="ReportingOnlyByGas">
              <TotalRow>
                <Quantity>100</Quantity>
                <CalculatedQuantity>100</CalculatedQuantity>
                <GasType>CO2bioC</GasType>
                <GasGroupType>None</GasGroupType>
              </TotalRow>
              <TotalRow>
                <Quantity>0.00000000</Quantity>
                <CalculatedQuantity>0.00000000</CalculatedQuantity>
                <GasType>CO2bionC</GasType>
                <GasGroupType>None</GasGroupType>
              </TotalRow>
              <GrandTotal>
                <Total>200</Total>
              </GrandTotal>
            </Emissions>
          </Totals>
        </TotalGroups>
      </TotalEmissions>
    </ActivityPages>
  </ActivityData>
</ReportData>
$$), ('2018-09-29T11:55:39.423', $$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ReportDetails>
    <ReportID>800855555</ReportID>
    <PrepopReportID></PrepopReportID>
    <ReportType>R7</ReportType>
    <FacilityId>666</FacilityId>
    <OrganisationId>1337</OrganisationId>
    <ReportingPeriodDuration>1999</ReportingPeriodDuration>
    <ReportStatus>
      <Status>In Progress</Status>
      <Version>3</Version>
      <LastModifiedBy>Donny Donaldson McDonaldface</LastModifiedBy>
      <LastModifiedDate>2018-09-28T11:55:39.423</LastModifiedDate>
    </ReportStatus>
  </ReportDetails>
  <ActivityData>
    <ActivityPages>
      <TotalEmissions>
        <TotalGroups TotalGroupType="TotalGHGEmissionGas">
          <Totals>
            <Emissions EmissionsGasType="GHGEmissionGas">
              <TotalRow>
                <Quantity></Quantity>
                <CalculatedQuantity></CalculatedQuantity>
                <GasType>CO2bioC</GasType>
                <GasGroupType>None</GasGroupType>
              </TotalRow>
              <TotalRow>
                <Quantity></Quantity>
                <CalculatedQuantity></CalculatedQuantity>
                <GasType>CO2bionC</GasType>
                <GasGroupType>None</GasGroupType>
              </TotalRow>
              <GrandTotal>
                <Total></Total>
              </GrandTotal>
            </Emissions>
          </Totals>
        </TotalGroups>
        <TotalGroups TotalGroupType="ReportingOnlyEmissions">
          <Totals>
            <Emissions EmissionsGasType="ReportingOnlyByGas">
              <TotalRow>
                <Quantity>100</Quantity>
                <CalculatedQuantity>100</CalculatedQuantity>
                <GasType>CO2bioC</GasType>
                <GasGroupType>None</GasGroupType>
              </TotalRow>
              <TotalRow>
                <Quantity>0.00000000</Quantity>
                <CalculatedQuantity>0.00000000</CalculatedQuantity>
                <GasType>CO2bionC</GasType>
                <GasGroupType>None</GasGroupType>
              </TotalRow>
              <GrandTotal>
                <Total></Total>
              </GrandTotal>
            </Emissions>
          </Totals>
        </TotalGroups>
      </TotalEmissions>
    </ActivityPages>
  </ActivityData>
</ReportData>
$$);

-- Ensure fixture is processed correctly
refresh materialized view swrs_transform.historical_report_emission_data with data;

-- select * from swrs_extract.eccc_xml_file;
select results_eq(
  $$
    select grand_total_emission, reporting_only_grand_total, co2bioc from swrs_transform.historical_report_emission_data where id=1
  $$,
  $$
    values (300::numeric, 200::numeric, 100::numeric)
  $$,
  'historical_report_emission_data parses the xml properly and returns the correct values'
);

select results_eq(
  $$
    select grand_total_emission, reporting_only_grand_total, co2bioc from swrs_transform.historical_report_emission_data where id=2
  $$,
  $$
    values (0::numeric, 0::numeric, 0::numeric)
  $$,
  'historical_report_emission_data parses empty values as zeroes'
);

select finish();
rollback;
