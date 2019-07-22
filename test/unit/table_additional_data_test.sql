set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

insert into ggircs_swrs_extract.ghgr_import (xml_file) values ($$
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

refresh materialized view ggircs_swrs_transform.report with data;
refresh materialized view ggircs_swrs_transform.organisation with data;
refresh materialized view ggircs_swrs_transform.facility with data;
refresh materialized view ggircs_swrs_transform.activity with data;
refresh materialized view ggircs_swrs_transform.additional_data with data;
refresh materialized view ggircs_swrs_transform.final_report with data;
select ggircs_swrs_transform.load_report();
select ggircs_swrs_transform.load_organisation();
select ggircs_swrs_transform.load_facility();
select ggircs_swrs_transform.load_activity();
select ggircs_swrs_transform.load_additional_data();

-- Table ggircs.additional_data exists
select has_table('ggircs'::name, 'additional_data'::name);

-- Additional Data has pk
select has_pk('ggircs', 'additional_data', 'ggircs_additional_data has primary key');

-- Additional Data has fk
select has_fk('ggircs', 'additional_data', 'ggircs_additional_data has foreign key constraint(s)');

-- Additional Data has data
select isnt_empty('select * from ggircs.additional_data', 'there is data in ggircs.additional_data');

-- FKey tests
-- Additional Data -> Activity
select set_eq(
    $$
    select distinct(activity.ghgr_import_id) from ggircs.additional_data
    join ggircs.activity
    on additional_data.activity_id = activity.id
    $$,

    'select distinct(ghgr_import_id) from ggircs.activity',

    'Foreign key activity_id in ggircs.additional_data references ggircs.activity.id'
);

-- Additional Data -> Report
select set_eq(
    $$
    select distinct(report.ghgr_import_id) from ggircs.additional_data
    join ggircs.report
    on additional_data.report_id = report.id
    $$,

    'select distinct(ghgr_import_id) from ggircs.report',

    'Foreign key report_id in ggircs.additional_data references ggircs.report.id'
);

-- Data in ggircs_swrs_transform.additional_data === data in ggircs.additional_data
select set_eq(
              $$
              select
                    ghgr_import_id,
                    grandparent,
                    parent,
                    class,
                    attribute,
                    attr_value,
                    node_value
                from ggircs_swrs_transform.additional_data
                order by
                  ghgr_import_id,
                  grandparent,
                  parent,
                  class,
                  node_value
                 asc
              $$,

              $$
              select
                    ghgr_import_id,
                    grandparent,
                    parent,
                    class,
                    attribute,
                    attr_value,
                    node_value
                from ggircs.additional_data
                order by
                  ghgr_import_id,
                  grandparent,
                  parent,
                  class,
                  node_value
                 asc
              $$,

              'data in ggircs_swrs_transform.additional_data === ggircs.additional_data');


select * from finish();
rollback;
