set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(14);

-- Test matview report exists in schema ggircs_swrs
select has_materialized_view('ggircs_swrs', 'organisation', 'Materialized view report exists');

-- -- Test column names in matview report exist and are correct
select has_column('ggircs_swrs', 'organisation', 'id', 'Matview organisation has column: id');
select has_column('ggircs_swrs', 'organisation', 'report_id', 'Matview organisation has column: report_id');
select has_column('ggircs_swrs', 'organisation', 'swrs_organisation_id', 'Matview organisation has column: swrs_organisation_id');
select has_column('ggircs_swrs', 'organisation', 'business_legal_name', 'Matview organisation has column: business_legal_name');
select has_column('ggircs_swrs', 'organisation', 'english_trade_name', 'Matview organisation has column: english_trade_name');
select has_column('ggircs_swrs', 'organisation', 'french_trade_name', 'Matview organisation has column: french_trade_name');
select has_column('ggircs_swrs', 'organisation', 'cra_business_number', 'Matview organisation has column: cra_business_number');
select has_column('ggircs_swrs', 'organisation', 'duns', 'Matview organisation has column: duns');
select has_column('ggircs_swrs', 'organisation', 'website', 'Matview organisation has column: website');
select has_column('ggircs_swrs', 'organisation', 'swrs_organisation_history_id', 'Matview organisation has column: swrs_organisation_history_id');
--
-- -- Test index names in matview report exist and are correct
select has_index('ggircs_swrs', 'organisation', 'ggircs_organisation_primary_key', 'Matview organisation has index: ggircs_organisation_primary_key');
select has_index('ggircs_swrs', 'organisation', 'ggircs_organisation_history', 'Matview organisation has index: ggircs_organisation_history');
--
-- -- Test unique indicies are defined unique
select index_is_unique('ggircs_swrs', 'organisation', 'ggircs_organisation_primary_key', 'Matview report index ggircs_organisation_primary_key is unique');
--
-- -- Test columns in matview report have correct types
-- select col_type_is('ggircs_swrs', 'report', 'id', 'bigint', 'Matview report column id has type bigint');

select finish();
rollback;
