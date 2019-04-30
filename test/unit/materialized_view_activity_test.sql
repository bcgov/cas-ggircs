set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(33);

select has_materialized_view(
    'ggircs_swrs', 'activity',
    'should have materialized view activity'
);

select has_index(
    'ggircs_swrs', 'activity',
    'table activity should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'activity'::name, array[
    'id'::name,
    'report_id'::name,
    'swrs_report_id'::name,
    'process_name'::name,
    'subprocess_name'::name,
    'information_requirement'::name,
    'sub_activity_xml'::name,
    'swrs_report_history_id'::name
]);

select has_column(       'ggircs_swrs', 'activity', 'id', 'column activity.id should exist');
select col_type_is(      'ggircs_swrs', 'activity', 'id', 'bigint', 'column activity.id should be type bigint');
--select col_not_null(     'ggircs_swrs', 'activity', 'id', 'column activity.id should be not null');
--select col_has_default(  'ggircs_swrs', 'activity', 'id', 'column activity.id should have a default');
--select col_default_is(   'ggircs_swrs', 'activity', 'id', 'nextval(''ggircs.activity_id_seq''::regclass)', 'column activity.id default is');

select has_column(       'ggircs_swrs', 'activity', 'report_id', 'column activity.report_id should exist');
select col_type_is(      'ggircs_swrs', 'activity', 'report_id', 'bigint', 'column activity.report_id should be type bigint');
select col_not_null(     'ggircs_swrs', 'activity', 'report id', 'column activity.report_id should be not null');
select col_hasnt_default('ggircs_swrs', 'activity', 'report_id', 'column activity.report_id should not  have a default');

select has_column(       'ggircs_swrs', 'activity', 'swrs_report_id', 'column activity.swrs_report_id should exist');
select col_type_is(      'ggircs_swrs', 'activity', 'swrs_report_id', 'numeric(1000,0)', 'column activity.swrs_report_id should be type numeric(1000,0)');
select col_is_null(      'ggircs_swrs', 'activity', 'swrs_report_id', 'column activity.swrs_report_id should allow null');
select col_hasnt_default('ggircs_swrs', 'activity', 'swrs_report_id', 'column activity.swrs_report_id should not  have a default');

select has_column(       'ggircs_swrs', 'activity', 'process_name', 'column activity.process_name should exist');
select col_type_is(      'ggircs_swrs', 'activity', 'process_name', 'character varying(1000)', 'column activity.process_name should be type text');
select col_is_null(      'ggircs_swrs', 'activity', 'process_name', 'column activity.process_name should allow null');
select col_hasnt_default('ggircs_swrs', 'activity', 'process_name', 'column activity.process_name should not  have a default');

select has_column(       'ggircs_swrs', 'activity', 'subprocess_name', 'column activity.subprocess_name should exist');
select col_type_is(      'ggircs_swrs', 'activity', 'subprocess_name', 'character varying(1000)', 'column activity.subprocess_name should be type text');
select col_is_null(      'ggircs_swrs', 'activity', 'subprocess_name', 'column activity.subprocess_name should allow null');
select col_hasnt_default('ggircs_swrs', 'activity', 'subprocess_name', 'column activity.subprocess_name should not  have a default');

select has_column(       'ggircs_swrs', 'activity', 'information_requirement', 'column activity.information_requirement should exist');
select col_type_is(      'ggircs_swrs', 'activity', 'information_requirement', 'character varying(1000)', 'column activity.information_requirement should be type text');
select col_is_null(      'ggircs_swrs', 'activity', 'information_requirement', 'column activity.information_requirement should allow null');
select col_hasnt_default('ggircs_swrs', 'activity', 'information_requirement', 'column activity.information_requirement should not  have a default');

select has_column(       'ggircs_swrs', 'activity', 'sub_activity_xml', 'column activity.sub_activity_xml should exist');
select col_type_is(      'ggircs_swrs', 'activity', 'sub_activity_xml', 'xml', 'column activity.sub_activity_xml should be type xml');
select col_is_null(      'ggircs_swrs', 'activity', 'sub_activity_xml', 'column activity.sub_activity_xml should allow null');
select col_hasnt_default('ggircs_swrs', 'activity', 'sub_activity_xml', 'column activity.sub_activity_xml should not  have a default');

select has_column(       'ggircs_swrs', 'activity', 'swrs_report_history_id', 'column activity.swrs_report_history_id should exist');
select col_type_is(      'ggircs_swrs', 'activity', 'swrs_report_history_id', 'bigint', 'column activity.swrs_report_history_id should be type bigint');
select col_is_null(      'ggircs_swrs', 'activity', 'swrs_report_history_id', 'column activity.swrs_report_history_id should allow null');
select col_hasnt_default('ggircs_swrs', 'activity', 'swrs_report_history_id', 'column activity.swrs_report_history_id should not  have a default');

select * from finish();
rollback;
