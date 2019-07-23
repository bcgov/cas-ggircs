set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

-- View should exist
select has_view(
    'swrs', 'naics_category_mapping',
    'swrs.naics_mapping_category should be a view'
);

-- Columns are correct
select columns_are('swrs'::name, 'naics_category_mapping'::name, array[
    'naics_code'::name,
    'naics_category'::name,
    'naics_category_type'::name,
    'naics_category_id'::name,
    'naics_category_type_id'::name,
    'report_id'::name,
    'facility_id'::name
]);

-- XML fixture for testing
insert into swrs_extract.ghgr_import (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
  <Facility>
  </Facility>
    <NAICSCodeList>
      <NAICSCode>
        <NAICSClassification>Chemical Pulp Mills </NAICSClassification>
        <Code>111000</Code>
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
</ReportData>
$$), ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
  <Facility>
  </Facility>
    <NAICSCodeList>
      <NAICSCode>
        <NAICSClassification>Chemical Pulp Mills </NAICSClassification>
        <Code>111419</Code>
        <NaicsPriority>Primary</NaicsPriority>
      </NAICSCode>
    </NAICSCodeList>
  </RegistrationData>
  <ReportDetails>
    <ReportID>123500000</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0002</FacilityId>
    <FacilityType>ABC</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2015</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Submitted</Status>
      <SubmissionDate>2013-03-28T19:25:55.32</SubmissionDate>
      <LastModifiedBy>Buddy</LastModifiedBy>
    </ReportStatus>
  </ReportDetails>
</ReportData>
$$);

-- Run table export function without clearing the materialized views (for data equality tests below)
SET client_min_messages TO WARNING; -- load is a bit verbose
select swrs_transform.load(true, false);

-- Test naics code -> category/type mapping
select set_eq(
    'select naics_category, naics_category_type from swrs.naics_category_mapping',
    $$
    select naics_category, naics_category_type from swrs.naics
    join swrs.naics_naics_category as nnc
        on naics.naics_code::text like nnc.naics_code_pattern
    join swrs.naics_category as nc
        on nnc.category_id = nc.id
    join swrs.naics_category_type as ct
        on nnc.category_type_id = ct.id
    $$,
    'swrs.naics_category_mapping properly selects categories and types from both fully and partially defined naics codes in the naics_naics_category through table'
);

select * from finish();
rollback;
