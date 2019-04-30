set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select no_plan();

select has_materialized_view(
    'ggircs_swrs', 'activity',
    'should have materialized view activity'
);

select has_index(
    'ggircs_swrs', 'activity', 'ggircs_activity_primary_key',
    'mat view activity should have a primary key'
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

select has_column(       'ggircs_swrs', 'activity', 'report_id', 'column activity.report_id should exist');
select col_type_is(      'ggircs_swrs', 'activity', 'report_id', 'bigint', 'column activity.report_id should be type bigint');
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

-- Insert data for fixture based testing

insert into ggircs_swrs.ghgr_import (xml_file) values ($$
  <ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ActivityData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ActivityPages>
      <Process ProcessName="GeneralStationaryCombustion">
        <SubProcess SubprocessName="(a) general stationary combustion, useful energy" InformationRequirement="Required">
        </SubProcess>
      </Process>
    </ActivityPages>
  </ActivityData>
</ReportData>
$$);


-- refresh necessary views with data

refresh materialized view ggircs_swrs.report with data; 
refresh materialized view ggircs_swrs.activity with data;

-- test the columns for matview facility have been properly parsed from xml
select results_eq('select id from ggircs_swrs.activity', ARRAY[1::bigint], 'Matview activity parsed column id');


select * from finish();
rollback;
