set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(3);

select has_materialized_view(
    'ggircs_swrs', 'parent_organisation',
    'ggircs_swrs.parent_organisation should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'parent_organisation', 'ggircs_parent_organisation_primary_key',
    'ggircs_swrs.parent_organisation should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'parent_organisation'::name, array[
    'ghgr_import_id'::name,
    'path_context'::name,
    'swrs_organisation_id'::name,
    'parent_organisation_idx'::name,
    'percentage_owned'::name,
    'french_trade_name'::name,
    'english_trade_name'::name,
    'duns'::name,
    'business_legal_name'::name,
    'website'::name
]);

refresh materialized view ggircs_swrs.parent_organisation with data;

-- TODO: Add a fixture to test the veracity of what is being pulled in to this view from xml

select * from finish();
rollback;
