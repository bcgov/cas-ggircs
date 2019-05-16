set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

select has_function( 'ggircs_swrs', 'export_mv_to_table', 'Schema ggircs_swrs has function export_mv_to_table()' );

select * from finish();
rollback;
