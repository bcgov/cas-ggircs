set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(24);

-- Test matview report exists in schema ggircs_swrs
select has_materialized_view('ggircs_swrs', 'organisation', 'ggircs_swrs.organisation exists as a materialized view');

-- -- Test column names in matview report exist and are correct
select has_column('ggircs_swrs', 'organisation', 'id', 'ggircs_swrs.organisation has column: id');
select has_column('ggircs_swrs', 'organisation', 'ghgr_import_id', 'ggircs_swrs.organisation has column: ghgr_import_id');
select has_column('ggircs_swrs', 'organisation', 'swrs_organisation_id', 'ggircs_swrs.organisation has column: swrs_organisation_id');
select has_column('ggircs_swrs', 'organisation', 'business_legal_name', 'ggircs_swrs.organisation has column: business_legal_name');
select has_column('ggircs_swrs', 'organisation', 'english_trade_name', 'ggircs_swrs.organisation has column: english_trade_name');
select has_column('ggircs_swrs', 'organisation', 'french_trade_name', 'ggircs_swrs.organisation has column: french_trade_name');
select has_column('ggircs_swrs', 'organisation', 'cra_business_number', 'ggircs_swrs.organisation has column: cra_business_number');
select has_column('ggircs_swrs', 'organisation', 'duns', 'ggircs_swrs.organisation has column: duns');
select has_column('ggircs_swrs', 'organisation', 'website', 'ggircs_swrs.organisation has column: website');
select has_column('ggircs_swrs', 'organisation', 'swrs_organisation_history_id', 'ggircs_swrs.organisation has column: swrs_organisation_history_id');
--
-- -- Test index names in matview report exist and are correct
select has_index('ggircs_swrs', 'organisation', 'ggircs_organisation_primary_key', 'ggircs_swrs.organisation has index: ggircs_organisation_primary_key');
select has_index('ggircs_swrs', 'organisation', 'ggircs_swrs_organisation_history', 'ggircs_swrs.organisation has index: ggircs_swrs_organisation_history');
--
-- -- Test unique indicies are defined unique
select index_is_unique('ggircs_swrs', 'organisation', 'ggircs_organisation_primary_key', 'ggircs_swrs.report index ggircs_organisation_primary_key is unique');
--
-- -- Test columns in matview report have correct types
select col_type_is('ggircs_swrs', 'organisation', 'id', 'bigint', 'ggircs_swrs.organisation column id has type bigint');
select col_type_is('ggircs_swrs', 'organisation', 'ghgr_import_id', 'integer', 'ggircs_swrs.organisation column ghgr_import_id has type integer');
select col_type_is('ggircs_swrs', 'organisation', 'swrs_organisation_id', 'numeric(1000,0)', 'ggircs_swrs.organisation column id has type numeric(1000,0)');
select col_type_is('ggircs_swrs', 'organisation', 'business_legal_name', 'character varying(1000)', 'ggircs_swrs.organisation column business_legal_name has type varchar');
select col_type_is('ggircs_swrs', 'organisation', 'english_trade_name', 'character varying(1000)', 'ggircs_swrs.organisation column english_trade_name has type varchar');
select col_type_is('ggircs_swrs', 'organisation', 'french_trade_name', 'character varying(1000)', 'ggircs_swrs.organisation column french_trade_name has type varchar');
select col_type_is('ggircs_swrs', 'organisation', 'cra_business_number', 'character varying(1000)', 'ggircs_swrs.organisation column cra_business_number has type varchar');
select col_type_is('ggircs_swrs', 'organisation', 'duns', 'character varying(1000)', 'ggircs_swrs.organisation column duns has type varchar');
select col_type_is('ggircs_swrs', 'organisation', 'website', 'character varying(1000)', 'ggircs_swrs.organisation column website has type varchar');
select col_type_is('ggircs_swrs', 'organisation', 'swrs_organisation_history_id', 'bigint', 'ggircs_swrs.organisation column swrs_organisation_history_id has type bigint');

select finish();
rollback;
