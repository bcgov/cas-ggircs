set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

insert into swrs_extract.eccc_xml_file (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ReportDetails>
    <ReportID>1234</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0000</FacilityId>
    <FacilityType>EIO</FacilityType>
    <OrganisationId>00001</OrganisationId>
    <ReportingPeriodDuration>2025</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Submitted</Status>
      <SubmissionDate>2013-03-27T19:25:55.32</SubmissionDate>
      <LastModifiedBy>Buddy</LastModifiedBy>
    </ReportStatus>
  </ReportDetails>
  <OperationalWorkerReport/>
</ReportData>
$$);

-- Run table export function without clearing the materialized views (for data equality tests below)
SET client_min_messages TO WARNING; -- load is a bit verbose
select swrs_transform.load(true, false);

select eccc_xml_file_id from swrs.report;
select '======';
select eccc_xml_file_id from swrs_transform.report;

-- Table swrs.report exists
select has_table('swrs'::name, 'report'::name);

-- Report has pk
select has_pk('swrs', 'report', 'ggircs_report has primary key');

-- Report has data
select isnt_empty('select * from swrs.report', 'there is data in swrs.report');

-- Data in swrs_transform.report === data in ggircs_report
select set_eq($$
                  select
                      eccc_xml_file_id,
                      imported_at,
                      swrs_report_id,
                      prepop_report_id,
                      report_type,
                      swrs_facility_id,
                      swrs_organisation_id,
                      reporting_period_duration,
                      status,
                      version,
                      submission_date,
                      last_modified_by,
                      last_modified_date,
                      update_comment
                  from swrs_transform.report
                  $$,

                 $$
                 select
                      eccc_xml_file_id,
                      imported_at,
                      swrs_report_id,
                      prepop_report_id,
                      report_type,
                      swrs_facility_id,
                      swrs_organisation_id,
                      reporting_period_duration,
                      status,
                      version,
                      submission_date,
                      last_modified_by,
                      last_modified_date,
                      update_comment
                  from swrs.report
                  $$,

    'data in swrs_transform.report === swrs.report');

select * from finish();
rollback;
