set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

insert into swrs_extract.eccc_xml_file (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
    <Organisation>
      <Details>
        <BusinessLegalName>Bart Simpson</BusinessLegalName>
        <EnglishTradeName>Bart Simpson</EnglishTradeName>
        <FrenchTradeName/>
        <CRABusinessNumber>12345</CRABusinessNumber>
        <DUNSNumber>0</DUNSNumber>
        <WebSite>www.nhl.com</WebSite>
      </Details>
    </Organisation>
    <Facility>
      <Details>
        <FacilityName>fname</FacilityName>
        <RelationshipType>Owned and Operated</RelationshipType>
        <PortabilityIndicator>N</PortabilityIndicator>
        <Status>Active</Status>
      </Details>
    </Facility>
    <Contacts/>
  </RegistrationData>
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
  <OperationalWorkerReport/>
  <VerifyTombstone>
    <Organisation>
      <Details>
        <BusinessLegalName>Bart Simpson</BusinessLegalName>
        <EnglishTradeName>Bart Simpson</EnglishTradeName>
        <CRABusinessNumber>123456778</CRABusinessNumber>
        <DUNSNumber>00-000-0000</DUNSNumber>
      </Details>
    </Organisation>
    <Facility>
      <Details>
        <FacilityName>Bart Simpson</FacilityName>
      </Details>
    </Facility>
  </VerifyTombstone>
  <ActivityData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ActivityPages>
      <Process ProcessName="ElectricityGeneration">
        <SubProcess SubprocessName="Emissions from fuel combustion for electricity generation" InformationRequirement="Required">
        </SubProcess>
      </Process>
      <Process>
        <SubProcess SubprocessName="Additional Reportable Information as per WCI.352(i)(1)-(12)" InformationRequirement="MandatoryAdditional">
          <Amount AmtDomain="PulpAndPaperBlackLiquor" AmtAction="Combusted" AmtPeriod="Annual">168389</Amount>
          <PercentSolidsByWeight>53</PercentSolidsByWeight>
          <PulpAndPaperCarbonates/>
        </SubProcess>
      </Process>
    </ActivityPages>
  </ActivityData>
</ReportData>
$$);

-- Run table export function without clearing the materialized views (for data equality tests below)
SET client_min_messages TO WARNING; -- load is a bit verbose
select swrs_transform.load(true, false);

-- Table swrs.additional_data exists
select has_table('swrs'::name, 'additional_data'::name);

-- Additional Data has pk
select has_pk('swrs', 'additional_data', 'ggircs_additional_data has primary key');

-- Additional Data has fk
select has_fk('swrs', 'additional_data', 'ggircs_additional_data has foreign key constraint(s)');

-- Additional Data has data
select isnt_empty('select * from swrs.additional_data', 'there is data in swrs.additional_data');

-- FKey tests
-- Additional Data -> Activity
select set_eq(
    $$
    select distinct(activity.eccc_xml_file_id) from swrs.additional_data
    join swrs.activity
    on additional_data.activity_id = activity.id
    $$,

    'select distinct(eccc_xml_file_id) from swrs.activity',

    'Foreign key activity_id in swrs.additional_data references swrs.activity.id'
);

-- Additional Data -> Report
select set_eq(
    $$
    select distinct(report.eccc_xml_file_id) from swrs.additional_data
    join swrs.report
    on additional_data.report_id = report.id
    $$,

    'select distinct(eccc_xml_file_id) from swrs.report',

    'Foreign key report_id in swrs.additional_data references swrs.report.id'
);

-- Data in swrs_transform.additional_data === data in swrs.additional_data
select set_eq(
              $$
              select
                    eccc_xml_file_id,
                    grandparent,
                    parent,
                    class,
                    attribute,
                    attr_value,
                    node_value
                from swrs_transform.additional_data
                order by
                  eccc_xml_file_id,
                  grandparent,
                  parent,
                  class,
                  node_value
                 asc
              $$,

              $$
              select
                    eccc_xml_file_id,
                    grandparent,
                    parent,
                    class,
                    attribute,
                    attr_value,
                    node_value
                from swrs.additional_data
                order by
                  eccc_xml_file_id,
                  grandparent,
                  parent,
                  class,
                  node_value
                 asc
              $$,

              'data in swrs_transform.additional_data === swrs.additional_data');


select * from finish();
rollback;
