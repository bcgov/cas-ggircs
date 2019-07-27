set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(45);

-- Test matview report exists in schema swrs_transform
select has_materialized_view('swrs_transform', 'report', 'Materialized view report exists');

-- Test column names in matview report exist and are correct
select has_column('swrs_transform', 'report', 'ghgr_import_id', 'Matview report has column: ghgr_import_id');
select has_column('swrs_transform', 'report', 'source_xml', 'Matview report has column: source_xml');
select has_column('swrs_transform', 'report', 'imported_at', 'Matview report has column: imported_at');
select has_column('swrs_transform', 'report', 'swrs_report_id', 'Matview report has column: swrs_report_id');
select has_column('swrs_transform', 'report', 'prepop_report_id', 'Matview report has column: prepop_report_id');
select has_column('swrs_transform', 'report', 'report_type', 'Matview report has column: report_type');
select has_column('swrs_transform', 'report', 'swrs_facility_id', 'Matview report has column: swrs_facility_id');
select has_column('swrs_transform', 'report', 'reporting_period_duration', 'Matview report has column: reporting_period_duration');
select has_column('swrs_transform', 'report', 'status', 'Matview report has column: status');
select has_column('swrs_transform', 'report', 'version', 'Matview report has column: version');
select has_column('swrs_transform', 'report', 'submission_date', 'Matview report has column: submission_date');
select has_column('swrs_transform', 'report', 'last_modified_by', 'Matview report has column: last_modified_by');
select has_column('swrs_transform', 'report', 'update_comment', 'Matview report has column: update_comment');

-- Test index names in matview report exist and are correct
select has_index('swrs_transform', 'report', 'ggircs_report_primary_key', 'Matview report has index: ggircs_report_primary_key');

-- Test unique indicies are defined unique
select index_is_unique('swrs_transform', 'report', 'ggircs_report_primary_key', 'Matview report index ggircs_report_primary_key is unique');

-- Test columns in matview report have correct types
select col_type_is('swrs_transform', 'report', 'ghgr_import_id', 'integer', 'Matview report column ghgr has type integer');
select col_type_is('swrs_transform', 'report', 'source_xml', 'xml', 'Matview report column source_xml has type xml');
select col_type_is('swrs_transform', 'report', 'imported_at', 'timestamp with time zone', 'Matview report column imported_at has type timestamp with time zone');
select col_type_is('swrs_transform', 'report', 'swrs_report_id', 'integer', 'Matview report column swrs_report_id has type integer');
select col_type_is('swrs_transform', 'report', 'prepop_report_id', 'integer', 'Matview report column prepop_report_id has type integer');
select col_type_is('swrs_transform', 'report', 'report_type', 'character varying(1000)', 'Matview report column report_type has type character varying(1000)');
select col_type_is('swrs_transform', 'report', 'swrs_facility_id', 'integer', 'Matview report column swrs_facility_id has type integer');
select col_type_is('swrs_transform', 'report', 'swrs_organisation_id', 'integer', 'Matview report column swrs_organisation_id has type integer');
select col_type_is('swrs_transform', 'report', 'reporting_period_duration', 'character varying(1000)', 'Matview report column reporting_period_duration has type numeric(1000,0)');
select col_type_is('swrs_transform', 'report', 'status', 'character varying(1000)', 'Matview report column status has type character varying(1000)');
select col_type_is('swrs_transform', 'report', 'version', 'character varying(1000)', 'Matview report column version has type character varying(1000)');
select col_type_is('swrs_transform', 'report', 'submission_date', 'timestamp with time zone', 'Matview report column submission_date has type character varying(1000)');
select col_type_is('swrs_transform', 'report', 'last_modified_by', 'character varying(1000)', 'Matview report column last_modified_by has type character varying(1000)');
select col_type_is('swrs_transform', 'report', 'update_comment', 'character varying(1000)', 'Matview report column update_comment has type character varying(1000)');

-- Setup fixture
insert into swrs_extract.ghgr_import (imported_at, xml_file) VALUES ('2018-09-29T11:55:39.423', $$
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
</ReportData>
$$);

-- Ensure fixture is processed correctly
refresh materialized view swrs_transform.report with data;
select results_eq('select ghgr_import_id from swrs_transform.report', 'select id from swrs_extract.ghgr_import', 'Matview report parsed column ghgr_import_id');
-- TODO(wenzowski): need an xml comparison operator
select results_eq('select source_xml::text from swrs_transform.report', ARRAY[$$
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
</ReportData>
$$::text], 'Matview report parsed column source_xml');
select results_eq('select imported_at from swrs_transform.report', ARRAY['2018-09-29T11:55:39.423'::timestamptz], 'Matview report parsed column imported_at');
select results_eq('select swrs_report_id from swrs_transform.report', ARRAY[800855555::integer], 'Matview report parsed column swrs_report_id');
select results_eq('select prepop_report_id from swrs_transform.report', ARRAY[null::integer], 'Matview report parsed column prepop_report_id');
select results_eq('select report_type from swrs_transform.report', ARRAY['R7'::varchar], 'Matview report parsed column report_type');
select results_eq('select swrs_facility_id from swrs_transform.report', ARRAY[666::integer], 'Matview report parsed column swrs_facility_id');
select results_eq('select swrs_organisation_id from swrs_transform.report', ARRAY[1337::integer], 'Matview report parsed column swrs_organisation_id');
select results_eq('select reporting_period_duration from swrs_transform.report', ARRAY[1999::varchar], 'Matview report parsed column reporting_period_duration');
select results_eq('select status from swrs_transform.report', ARRAY['In Progress'::varchar], 'Matview report parsed column status');
select results_eq('select version from swrs_transform.report', ARRAY[3::varchar], 'Matview report parsed column version');
select results_eq('select submission_date from swrs_transform.report', ARRAY[null::timestamptz], 'Matview report parsed column submission_date');
select results_eq('select last_modified_by from swrs_transform.report', ARRAY['Donny Donaldson McDonaldface'::varchar], 'Matview report parsed column last_modified_by');
select results_eq('select last_modified_date from swrs_transform.report', ARRAY['2018-09-28T11:55:39.423'::timestamptz], 'Matview report parsed column last_modified_date');
select results_eq('select update_comment from swrs_transform.report', ARRAY[null::varchar], 'Matview report parsed column update_comment');

select finish();
rollback;
