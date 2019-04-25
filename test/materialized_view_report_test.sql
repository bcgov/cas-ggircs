set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(19);

-- Test matview report exists in schema ggircs_private
select has_materialized_view('ggircs_private', 'report', 'Materialized view report exists');

-- Test column names in matview report exist and are correct
select has_column('ggircs_private', 'report', 'id', 'Matview report has column: id');
select has_column('ggircs_private', 'report', 'ghgr_id', 'Matview report has column: ghgr_id');
select has_column('ggircs_private', 'report', 'source_xml', 'Matview report has column: source_xml');
select has_column('ggircs_private', 'report', 'imported_at', 'Matview report has column: imported_at');
select has_column('ggircs_private', 'report', 'swim_report_id', 'Matview report has column: swim_report_id');
select has_column('ggircs_private', 'report', 'prepop_report_id', 'Matview report has column: prepop_report_id');
select has_column('ggircs_private', 'report', 'report_type', 'Matview report has column: report_type');
select has_column('ggircs_private', 'report', 'swim_facility_id', 'Matview report has column: swim_facility_id');
select has_column('ggircs_private', 'report', 'reporting_period_duration', 'Matview report has column: reporting_period_duration');
select has_column('ggircs_private', 'report', 'status', 'Matview report has column: status');
select has_column('ggircs_private', 'report', 'version', 'Matview report has column: version');
select has_column('ggircs_private', 'report', 'submission_date', 'Matview report has column: submission_date');
select has_column('ggircs_private', 'report', 'last_modified_by', 'Matview report has column: last_modified_by');
select has_column('ggircs_private', 'report', 'update_comment', 'Matview report has column: update_comment');
select has_column('ggircs_private', 'report', 'swim_report_history_id', 'Matview report has column: swim_report_history_id');

-- Test index names in matview report exist and are correct
select has_index('ggircs_private', 'report', 'ggircs_private_report_primary_key', 'Matview report has index: ggircs_private_report_primary_key');
select has_index('ggircs_private', 'report', 'ggircs_private_report_history', 'Matview report has index: ggircs_private_report_history');

-- Test unique indicies are defined unique
select index_is_unique('ggircs_private', 'report', 'ggircs_private_report_primary_key', 'Matview report index ggircs_private_report_primary_key is unique');

-- Test columns in matview report have correct types
-- select col_type_is('ggircs_private', 'raw_report', 'id', 'integer', 'Column id has type integer');

-- Test NOT NULL columns have constraint
-- select col_not_null('ggircs_private', 'report', 'source_xml', 'Column source_xml has NOT NULL constraint');

-- Test default columns have default
-- select col_has_default('ggircs_private', 'raw_report', 'imported_at', 'Column imported_at has default');

-- Test default columns have correct default value
-- select col_default_is('ggircs_private', 'raw_report', 'imported_at', 'now()', 'Column imported_at defaults to now()');

select finish();
rollback;
