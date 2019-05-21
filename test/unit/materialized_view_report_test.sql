set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(52);

-- Test matview report exists in schema ggircs_swrs
select has_materialized_view('ggircs_swrs', 'report', 'Materialized view report exists');

-- Test column names in matview report exist and are correct
select has_column('ggircs_swrs', 'report', 'id', 'Matview report has column: id');
select has_column('ggircs_swrs', 'report', 'ghgr_import_id', 'Matview report has column: ghgr_import_id');
select has_column('ggircs_swrs', 'report', 'source_xml', 'Matview report has column: source_xml');
select has_column('ggircs_swrs', 'report', 'imported_at', 'Matview report has column: imported_at');
select has_column('ggircs_swrs', 'report', 'swrs_report_id', 'Matview report has column: swrs_report_id');
select has_column('ggircs_swrs', 'report', 'prepop_report_id', 'Matview report has column: prepop_report_id');
select has_column('ggircs_swrs', 'report', 'report_type', 'Matview report has column: report_type');
select has_column('ggircs_swrs', 'report', 'swrs_facility_id', 'Matview report has column: swrs_facility_id');
select has_column('ggircs_swrs', 'report', 'reporting_period_duration', 'Matview report has column: reporting_period_duration');
select has_column('ggircs_swrs', 'report', 'status', 'Matview report has column: status');
select has_column('ggircs_swrs', 'report', 'version', 'Matview report has column: version');
select has_column('ggircs_swrs', 'report', 'submission_date', 'Matview report has column: submission_date');
select has_column('ggircs_swrs', 'report', 'last_modified_by', 'Matview report has column: last_modified_by');
select has_column('ggircs_swrs', 'report', 'update_comment', 'Matview report has column: update_comment');
select has_column('ggircs_swrs', 'report', 'swrs_report_history_id', 'Matview report has column: swrs_report_history_id');

-- Test index names in matview report exist and are correct
select has_index('ggircs_swrs', 'report', 'ggircs_report_primary_key', 'Matview report has index: ggircs_report_primary_key');
select has_index('ggircs_swrs', 'report', 'ggircs_swrs_report_history', 'Matview report has index: ggircs_swrs_report_history');

-- Test unique indicies are defined unique
select index_is_unique('ggircs_swrs', 'report', 'ggircs_report_primary_key', 'Matview report index ggircs_report_primary_key is unique');

-- Test columns in matview report have correct types
select col_type_is('ggircs_swrs', 'report', 'id', 'bigint', 'Matview report column id has type bigint');
select col_type_is('ggircs_swrs', 'report', 'ghgr_import_id', 'integer', 'Matview report column ghgr has type integer');
select col_type_is('ggircs_swrs', 'report', 'source_xml', 'xml', 'Matview report column source_xml has type xml');
select col_type_is('ggircs_swrs', 'report', 'imported_at', 'timestamp with time zone', 'Matview report column imported_at has type timestamp with time zone');
select col_type_is('ggircs_swrs', 'report', 'swrs_report_id', 'integer', 'Matview report column swrs_report_id has type integer');
select col_type_is('ggircs_swrs', 'report', 'prepop_report_id', 'integer', 'Matview report column prepop_report_id has type integer');
select col_type_is('ggircs_swrs', 'report', 'report_type', 'character varying(1000)', 'Matview report column report_type has type character varying(1000)');
select col_type_is('ggircs_swrs', 'report', 'swrs_facility_id', 'integer', 'Matview report column swrs_facility_id has type integer');
select col_type_is('ggircs_swrs', 'report', 'swrs_organisation_id', 'integer', 'Matview report column swrs_organisation_id has type integer');
select col_type_is('ggircs_swrs', 'report', 'reporting_period_duration', 'integer', 'Matview report column reporting_period_duration has type numeric(1000,0)');
select col_type_is('ggircs_swrs', 'report', 'status', 'character varying(1000)', 'Matview report column status has type character varying(1000)');
select col_type_is('ggircs_swrs', 'report', 'version', 'character varying(1000)', 'Matview report column version has type character varying(1000)');
select col_type_is('ggircs_swrs', 'report', 'submission_date', 'timestamp with time zone', 'Matview report column submission_date has type character varying(1000)');
select col_type_is('ggircs_swrs', 'report', 'last_modified_by', 'character varying(1000)', 'Matview report column last_modified_by has type character varying(1000)');
select col_type_is('ggircs_swrs', 'report', 'update_comment', 'character varying(1000)', 'Matview report column update_comment has type character varying(1000)');
select col_type_is('ggircs_swrs', 'report', 'swrs_report_history_id', 'bigint', 'Matview report column swrs_report_history_id has type bigint');

-- Setup fixture
insert into ggircs_swrs.ghgr_import (imported_at, xml_file) VALUES ('2018-09-29T11:55:39.423', $$
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
refresh materialized view ggircs_swrs.report with data;
select results_eq('select id from ggircs_swrs.report', ARRAY[1::bigint], 'Matview report parsed column id');
select results_eq('select ghgr_import_id from ggircs_swrs.report', 'select id from ggircs_swrs.ghgr_import', 'Matview report parsed column ghgr_import_id');
-- TODO(wenzowski): need an xml comparison operator
select results_eq('select source_xml::text from ggircs_swrs.report', ARRAY[$$
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
select results_eq('select imported_at from ggircs_swrs.report', ARRAY['2018-09-29T11:55:39.423'::timestamptz], 'Matview report parsed column imported_at');
select results_eq('select swrs_report_id from ggircs_swrs.report', ARRAY[800855555::integer], 'Matview report parsed column swrs_report_id');
select results_eq('select prepop_report_id from ggircs_swrs.report', ARRAY[null::integer], 'Matview report parsed column prepop_report_id');
select results_eq('select report_type from ggircs_swrs.report', ARRAY['R7'::varchar], 'Matview report parsed column report_type');
select results_eq('select swrs_facility_id from ggircs_swrs.report', ARRAY[666::integer], 'Matview report parsed column swrs_facility_id');
select results_eq('select swrs_organisation_id from ggircs_swrs.report', ARRAY[1337::integer], 'Matview report parsed column swrs_organisation_id');
select results_eq('select reporting_period_duration from ggircs_swrs.report', ARRAY[1999::integer], 'Matview report parsed column reporting_period_duration');
select results_eq('select status from ggircs_swrs.report', ARRAY['In Progress'::varchar], 'Matview report parsed column status');
select results_eq('select version from ggircs_swrs.report', ARRAY[3::varchar], 'Matview report parsed column version');
select results_eq('select submission_date from ggircs_swrs.report', ARRAY[null::timestamptz], 'Matview report parsed column submission_date');
select results_eq('select last_modified_by from ggircs_swrs.report', ARRAY['Donny Donaldson McDonaldface'::varchar], 'Matview report parsed column last_modified_by');
select results_eq('select last_modified_date from ggircs_swrs.report', ARRAY['2018-09-28T11:55:39.423'::timestamptz], 'Matview report parsed column last_modified_date');
select results_eq('select update_comment from ggircs_swrs.report', ARRAY[null::varchar], 'Matview report parsed column update_comment');
select results_eq('select swrs_report_history_id from ggircs_swrs.report', ARRAY[1::bigint], 'Matview report parsed column swrs_report_history_id');

select finish();
rollback;
