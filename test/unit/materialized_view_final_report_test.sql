set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(11);

select has_materialized_view(
    'ggircs_swrs', 'final_report',
    'ggircs_swrs.final_report should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'final_report', 'ggircs_final_report_primary_key',
    'ggircs_swrs.final_report should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'final_report'::name, array[
    'id'::name,
    'swrs_report_id'::name,
    'ghgr_import_id'::name
]);

--  select has_column(       'ggircs_swrs', 'final_report', 'swrs_report_id', 'final_report.swrs_report_id column should exist');
select col_type_is(      'ggircs_swrs', 'final_report', 'swrs_report_id', 'integer', 'final_report.swrs_report_id column should be type bigint');
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
</ReportData>
$$);


insert into ggircs_swrs.table_ignore_organisation (swrs_organisation_id)
values (5367)
     , (5401)
     , (6432)
     , (29004)
     , (29110)
     , (40627)
     , (42118)
     , (42261)
     , (42288)
     , (50606)
     , (100251)
     , (100306)
     , (111616)
     , (111619)
     , (111620)
     , (111911)
     , (112130)
     , (112291)
     , (112466)
     , (112649)
     , (112685)
     , (112706)
     , (113002)
     , (113119) --This is the tested organisation_id
on conflict (swrs_organisation_id) do nothing;

-- Ensure fixture is processed correctly
refresh materialized view ggircs_swrs.report with data;
refresh materialized view ggircs_swrs.final_report with data;

-- Test ghgr_import_id fk relation
select results_eq(
    $$
    select report.swrs_report_id from ggircs_swrs.final_report
    join ggircs_swrs.report
    on
    final_report.swrs_report_id = report.swrs_report_id
    $$,

    'select swrs_report_id from ggircs_swrs.report',

    'Foreign key ghgr_import_id in ggircs_swrs_final_report references ggircs_swrs.report'
);

select results_eq(
  'select swrs_report_id from ggircs_swrs.final_report',
  array['800855555'::integer],
  'ggircs_swrs.final_report.swrs_report_id should contain one single value'
);

select results_eq(
  'select ghgr_import_id from ggircs_swrs.final_report',
  $$ select ghgr_import_id from ggircs_swrs.report where status = 'Archived' $$,
  'ggircs_swrs.final_report.ghgr_import_id should refer to the correct version'
);

delete from ggircs_swrs.ghgr_import where id < 200;
insert into ggircs_swrs.ghgr_import (imported_at, xml_file) VALUES
('2018-09-29T11:55:39.423', $$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ReportDetails>
    <ReportID>800855555</ReportID>
    <PrepopReportID></PrepopReportID>
    <ReportType>R7</ReportType>
    <FacilityId>666</FacilityId>
    <OrganisationId>113119</OrganisationId>
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
    <OrganisationId>113119</OrganisationId>
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
    <OrganisationId>113119</OrganisationId>
    <ReportingPeriodDuration>1999</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Archived</Status>
      <SubmissionDate>2018-11-14T12:35:27.226</SubmissionDate>
      <Version>3</Version>
      <LastModifiedBy>Donny Donaldson McDonaldface</LastModifiedBy>
      <LastModifiedDate>2018-11-14T12:35:27.226</LastModifiedDate>
    </ReportStatus>
  </ReportDetails>
</ReportData>
$$), ('2018-12-15T12:35:27.226', $$
    <ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ReportDetails>
    <ReportID>12345</ReportID>
    <PrepopReportID></PrepopReportID>
    <ReportType>R7</ReportType>
    <FacilityId>666</FacilityId>
    <OrganisationId>113119</OrganisationId>
    <ReportingPeriodDuration>1999</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Bad-Data</Status>
      <SubmissionDate>2018-11-14T12:35:27.226</SubmissionDate>
      <Version>3</Version>
      <LastModifiedBy>Donny Donaldson McDonaldface</LastModifiedBy>
      <LastModifiedDate>2018-11-14T12:35:27.226</LastModifiedDate>
    </ReportStatus>
  </ReportDetails>
</ReportData>
$$);

-- Test that the ignore_list is properly ignoring reports by swrs_organisation_id
select is_empty(
    'select * from ggircs_swrs.final_report where swrs_report_id = 12345',
    'ggircs_swrs.final_report ignored value from table_ignore_organisation'
);

select * from finish();
rollback;
