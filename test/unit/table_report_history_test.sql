set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(5);

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
    </ActivityPages>
  </ActivityData>
</ReportData>
$$);

-- Run table export function without clearing the materialized views (for data equality tests below)
SET client_min_messages TO WARNING; -- load is a bit verbose
select swrs_transform.load(true, false);

-- Table swrs.report exists
select has_table('swrs_history'::name, 'report'::name);

-- Report has pk
select has_pk('swrs_history', 'report', 'ggircs_report has primary key');

-- Report has data
select isnt_empty('select * from swrs_history.report', 'there is data in swrs.report');

-- Report has correct emission total data
select results_eq(
  $$
    select grand_total_less_co2bioc, reporting_only_grand_total, co2bioc from swrs_history.report where id=1;
  $$,
  $$
    values(200::numeric, 200::numeric, 100::numeric)
  $$,
  'The swrs_history.report received the correct total emission data'
);

-- The join in load_report_history does not remove report rows (is a left join)
select is (
  (select count(*) from swrs_history.report),
  2::bigint,
  'A report row is still generated if there is no TotalEmissions tag'
);

select * from finish();
rollback;
