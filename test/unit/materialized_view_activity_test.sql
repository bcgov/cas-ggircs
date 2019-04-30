SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(36);

SELECT has_materialized_view(
    'ggircs_swrs', 'activity',
    'Should have materialized view activity'
);

SELECT has_pk(
    'ggircs_swrs', 'activity',
    'Table activity should have a primary key'
);

SELECT columns_are('ggircs_swrs'::name, 'activity'::name, ARRAY[
    'id'::name,
    'report_id'::name,
    'swim_report_id'::name,
    'process_name'::name,
    'subprocess_name'::name,
    'information_requirement'::name,
    'sub_activity_xml'::name,
    'swim_report_history_id'::name
]);

SELECT has_column(       'ggircs_swrs', 'activity', 'id', 'Column activity.id should exist');
SELECT col_type_is(      'ggircs_swrs', 'activity', 'id', 'bigint', 'Column activity.id should be type bigint');
SELECT col_not_null(     'ggircs_swrs', 'activity', 'id', 'Column activity.id should be NOT NULL');
SELECT col_has_default(  'ggircs_swrs', 'activity', 'id', 'Column activity.id should have a default');
SELECT col_default_is(   'ggircs_swrs', 'activity', 'id', 'nextval(''ggircs.activity_id_seq''::regclass)', 'Column activity.id default is');

SELECT has_column(       'ggircs_swrs', 'activity', 'report_id', 'Column activity.report_id should exist');
SELECT col_type_is(      'ggircs_swrs', 'activity', 'report_id', 'bigint', 'Column activity.report_id should be type bigint');
SELECT col_not_null(     'ggircs_swrs', 'activity', 'report_id', 'Column activity.report_id should be NOT NULL');
SELECT col_hasnt_default('ggircs_swrs', 'activity', 'report_id', 'Column activity.report_id should not  have a default');

SELECT has_column(       'ggircs_swrs', 'activity', 'swim_report_id', 'Column activity.swim_report_id should exist');
SELECT col_type_is(      'ggircs_swrs', 'activity', 'swim_report_id', 'numeric(1000,0)', 'Column activity.swim_report_id should be type numeric(1000,0)');
SELECT col_is_null(      'ggircs_swrs', 'activity', 'swim_report_id', 'Column activity.swim_report_id should allow NULL');
SELECT col_hasnt_default('ggircs_swrs', 'activity', 'swim_report_id', 'Column activity.swim_report_id should not  have a default');

SELECT has_column(       'ggircs_swrs', 'activity', 'process_name', 'Column activity.process_name should exist');
SELECT col_type_is(      'ggircs_swrs', 'activity', 'process_name', 'text', 'Column activity.process_name should be type text');
SELECT col_is_null(      'ggircs_swrs', 'activity', 'process_name', 'Column activity.process_name should allow NULL');
SELECT col_hasnt_default('ggircs_swrs', 'activity', 'process_name', 'Column activity.process_name should not  have a default');

SELECT has_column(       'ggircs_swrs', 'activity', 'subprocess_name', 'Column activity.subprocess_name should exist');
SELECT col_type_is(      'ggircs_swrs', 'activity', 'subprocess_name', 'text', 'Column activity.subprocess_name should be type text');
SELECT col_is_null(      'ggircs_swrs', 'activity', 'subprocess_name', 'Column activity.subprocess_name should allow NULL');
SELECT col_hasnt_default('ggircs_swrs', 'activity', 'subprocess_name', 'Column activity.subprocess_name should not  have a default');

SELECT has_column(       'ggircs_swrs', 'activity', 'information_requirement', 'Column activity.information_requirement should exist');
SELECT col_type_is(      'ggircs_swrs', 'activity', 'information_requirement', 'text', 'Column activity.information_requirement should be type text');
SELECT col_is_null(      'ggircs_swrs', 'activity', 'information_requirement', 'Column activity.information_requirement should allow NULL');
SELECT col_hasnt_default('ggircs_swrs', 'activity', 'information_requirement', 'Column activity.information_requirement should not  have a default');

SELECT has_column(       'ggircs_swrs', 'activity', 'sub_activity_xml', 'Column activity.sub_activity_xml should exist');
SELECT col_type_is(      'ggircs_swrs', 'activity', 'sub_activity_xml', 'xml', 'Column activity.sub_activity_xml should be type xml');
SELECT col_is_null(      'ggircs_swrs', 'activity', 'sub_activity_xml', 'Column activity.sub_activity_xml should allow NULL');
SELECT col_hasnt_default('ggircs_swrs', 'activity', 'sub_activity_xml', 'Column activity.sub_activity_xml should not  have a default');

SELECT has_column(       'ggircs_swrs', 'activity', 'swim_report_history_id', 'Column activity.swim_report_history_id should exist');
SELECT col_type_is(      'ggircs_swrs', 'activity', 'swim_report_history_id', 'bigint', 'Column activity.swim_report_history_id should be type bigint');
SELECT col_is_null(      'ggircs_swrs', 'activity', 'swim_report_history_id', 'Column activity.swim_report_history_id should allow NULL');
SELECT col_hasnt_default('ggircs_swrs', 'activity', 'swim_report_history_id', 'Column activity.swim_report_history_id should not  have a default');

SELECT * FROM finish();
ROLLBACK;
