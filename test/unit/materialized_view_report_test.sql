set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(35);

-- Test matview report exists in schema ggircs_swrs
select has_materialized_view('ggircs_swrs', 'report', 'Materialized view report exists');

-- Test column names in matview report exist and are correct
select has_column('ggircs_swrs', 'report', 'id', 'Matview report has column: id');
select has_column('ggircs_swrs', 'report', 'ghgr_id', 'Matview report has column: ghgr_id');
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
select has_index('ggircs_swrs', 'report', 'ggircs_swrs_report_primary_key', 'Matview report has index: ggircs_swrs_report_primary_key');
select has_index('ggircs_swrs', 'report', 'ggircs_swrs_report_history', 'Matview report has index: ggircs_swrs_report_history');

-- Test unique indicies are defined unique
select index_is_unique('ggircs_swrs', 'report', 'ggircs_swrs_report_primary_key', 'Matview report index ggircs_swrs_report_primary_key is unique');

-- Test columns in matview report have correct types
select col_type_is('ggircs_swrs', 'report', 'id', 'bigint', 'Matview report column id has type bigint');
select col_type_is('ggircs_swrs', 'report', 'ghgr_id', 'integer', 'Matview report column ghgr has type integer');
select col_type_is('ggircs_swrs', 'report', 'source_xml', 'xml', 'Matview report column source_xml has type xml');
select col_type_is('ggircs_swrs', 'report', 'imported_at', 'timestamp with time zone', 'Matview report column imported_at has type timestamp with time zone');
select col_type_is('ggircs_swrs', 'report', 'swrs_report_id', 'numeric(1000,0)', 'Matview report column swrs_report_id has type numeric(1000,0)');
select col_type_is('ggircs_swrs', 'report', 'prepop_report_id', 'numeric(1000,0)', 'Matview report column prepop_report_id has type numeric(1000,0)');
select col_type_is('ggircs_swrs', 'report', 'report_type', 'character varying(1000)', 'Matview report column report_type has type character varying(1000)');
select col_type_is('ggircs_swrs', 'report', 'swrs_facility_id', 'numeric(1000,0)', 'Matview report column swrs_facility_id has type numeric(1000,0)');
select col_type_is('ggircs_swrs', 'report', 'swrs_organisation_id', 'numeric(1000,0)', 'Matview report column swrs_organisation_id has type numeric(1000,0)');
select col_type_is('ggircs_swrs', 'report', 'reporting_period_duration', 'numeric(1000,0)', 'Matview report column reporting_period_duration has type numeric(1000,0)');
select col_type_is('ggircs_swrs', 'report', 'status', 'character varying(1000)', 'Matview report column status has type character varying(1000)');
select col_type_is('ggircs_swrs', 'report', 'version', 'character varying(1000)', 'Matview report column version has type character varying(1000)');
select col_type_is('ggircs_swrs', 'report', 'submission_date', 'character varying(1000)', 'Matview report column submission_date has type character varying(1000)');
select col_type_is('ggircs_swrs', 'report', 'last_modified_by', 'character varying(1000)', 'Matview report column last_modified_by has type character varying(1000)');
select col_type_is('ggircs_swrs', 'report', 'update_comment', 'character varying(1000)', 'Matview report column update_comment has type character varying(1000)');
select col_type_is('ggircs_swrs', 'report', 'swrs_report_history_id', 'bigint', 'Matview report column swrs_report_history_id has type bigint');

select finish();
rollback;
