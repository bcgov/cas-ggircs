set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(9);

select has_materialized_view(
    'ggircs_swrs', 'final_report',
    'ggircs_swrs.final_report should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'final_report', 'ggircs_final_report_primary_key',
    'ggircs_swrs.final_report should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'final_report'::name, array[
    'swrs_report_id'::name,
    'ghgr_import_id'::name
]);

--  select has_column(       'ggircs_swrs', 'final_report', 'swrs_report_id', 'final_report.swrs_report_id column should exist');
select col_type_is(      'ggircs_swrs', 'final_report', 'swrs_report_id', 'numeric(1000,0)', 'final_report.swrs_report_id column should be type bigint');
select col_hasnt_default('ggircs_swrs', 'final_report', 'swrs_report_id', 'final_report.swrs_report_id column should not have a default value');

--  select has_column(       'ggircs_swrs', 'final_report', 'ghgr_import_id', 'final_report.ghgr_import_id column should exist');
select col_type_is(      'ggircs_swrs', 'final_report', 'ghgr_import_id', 'integer', 'final_report.ghgr_import_id column should be type bigint');
select col_hasnt_default('ggircs_swrs', 'final_report', 'ghgr_import_id', 'final_report.ghgr_import_id column should not have a default value');

-- Setup fixture
insert into ggircs_swrs.ghgr_import (imported_at, xml_file) VALUES
('2018-09-29T11:55:39.423', $$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ReportDetails>
    <ReportID>800855555</ReportID>
    <PrepopReportID></PrepopReportID>
    <ReportType>R7</ReportType>
    <FacilityId>666</FacilityId>
    <OrganisationId>1337</OrganisationId>
    <ReportingPeriodDuration>1999</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Completed</Status>
      <Version>3</Version>
      <LastModifiedBy>Donny Donaldson McDonaldface</LastModifiedBy>
      <LastModifiedDate>2018-09-28T11:55:39.423</LastModifiedDate>
    </ReportStatus>
  </ReportDetails>
</ReportData>
$$), ('2018-10-15T12:35:27.226', $$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ReportDetails>
    <ReportID>800855555</ReportID>
    <PrepopReportID></PrepopReportID>
    <ReportType>R7</ReportType>
    <FacilityId>666</FacilityId>
    <OrganisationId>1337</OrganisationId>
    <ReportingPeriodDuration>1999</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Submitted</Status>
      <SubmissionDate>2018-10-14T12:35:27.226</SubmissionDate>
      <Version>3</Version>
      <LastModifiedBy>Donny Donaldson McDonaldface</LastModifiedBy>
      <LastModifiedDate>2018-10-14T12:35:27.226</LastModifiedDate>
    </ReportStatus>
  </ReportDetails>
</ReportData>
$$), ('2018-11-15T12:35:27.226', $$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ReportDetails>
    <ReportID>800855555</ReportID>
    <PrepopReportID></PrepopReportID>
    <ReportType>R7</ReportType>
    <FacilityId>666</FacilityId>
    <OrganisationId>1337</OrganisationId>
    <ReportingPeriodDuration>1999</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Archived</Status>
      <SubmissionDate>2018-11-14T12:35:27.226</SubmissionDate>
      <Version>3</Version>
      <LastModifiedBy>Donny Donaldson McDonaldface</LastModifiedBy>
      <LastModifiedDate>2018-11-14T12:35:27.226</LastModifiedDate>
    </ReportStatus>
  </ReportDetails>
</ReportData>$$
);

-- Ensure fixture is processed correctly
refresh materialized view ggircs_swrs.report with data;
refresh materialized view ggircs_swrs.final_report with data;

select results_eq(
  'select swrs_report_id from ggircs_swrs.final_report',
  array['800855555'::numeric],
  'ggircs_swrs.final_report.swrs_report_id should contain one single value'
);
select results_eq(
  $$select ghgr_import_id from ggircs_swrs.final_report$$,
  $$select ghgr_import_id from ggircs_swrs.report where status = 'Archived'$$,
  'ggircs_swrs.final_report.ghgr_import_id should refer to the correct version'
);

select * from finish();
rollback;
