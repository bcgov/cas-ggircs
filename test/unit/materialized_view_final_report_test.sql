set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(7);

select has_materialized_view(
    'ggircs_swrs', 'final_report',
    'ggircs_swrs.final_report should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'final_report', 'ggircs_final_report_primary_key',
    'ggircs_swrs.final_report should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'final_report'::name, array[
    'report_id'::name,
    'facility_id'::name
]);

--  select has_column(       'ggircs_swrs', 'final_report', 'report_id', 'final_report.report_id column should exist');
select col_type_is(      'ggircs_swrs', 'final_report', 'report_id', 'bigint', 'final_report.report_id column should be type bigint');
select col_hasnt_default('ggircs_swrs', 'final_report', 'report_id', 'final_report.report_id column should not have a default value');

--  select has_column(       'ggircs_swrs', 'final_report', 'facility_id_', 'final_report.facility_id column should exist');
select col_type_is(      'ggircs_swrs', 'final_report', 'facility_id', 'bigint', 'final_report.facility_id column should be type bigint');
select col_hasnt_default('ggircs_swrs', 'final_report', 'facility_id', 'final_report.facility_id column should not have a default value');

select * from finish();
rollback;
