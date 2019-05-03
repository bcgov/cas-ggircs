set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(12);

select has_materialized_view(
    'ggircs_swrs', 'emission',
    'ggircs_swrs.emission should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'emission', 'ggircs_emission_primary_key',
    'ggircs_swrs.emission should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'emission'::name, array[
    'id'::name,
    'ghgr_import_id'::name,
    'fuel_id'::name,
    'activity_id'::name,
    'unit_id'::name,
    'fuel_type'::name,
    'emission_type'::name,
    'gas_type'::name,
    'methodology'::name,
    'not_applicable'::name,
    'quantity'::name,
    'calculated_quantity'::name,
    'emission_category'::name

]);

--  select has_column(       'ggircs_swrs', 'emission', 'id', 'emission.id column should exist');
select col_type_is(      'ggircs_swrs', 'emission', 'id', 'bigint', 'emission.id column should be type bigint');

--  select has_column(       'ggircs_swrs', 'emission', 'ghgr_import_id', 'emission.ghgr_import_id column should exist');
select col_type_is(      'ggircs_swrs', 'emission', 'ghgr_import_id', 'integer', 'emission.ghgr_import_id column should be type integer');
select col_hasnt_default('ggircs_swrs', 'emission', 'ghgr_import_id', 'emission.ghgr_import_id column should not have a default value');

--  select has_column(       'ggircs_swrs', 'emission', 'activity_id', 'emission.activity_id column should exist');
select col_type_is(      'ggircs_swrs', 'emission', 'activity_id', 'bigint', 'emission.activity_id column should be type bigint');
select col_is_null(      'ggircs_swrs', 'emission', 'activity_id', 'emission.activity_id column should allow null');
select col_hasnt_default('ggircs_swrs', 'emission', 'activity_id', 'emission.activity_id column should not  have a default');


--  select has_column(       'ggircs_swrs', 'emission', 'unit_id', 'emission.unit_id column should exist');
select col_type_is(      'ggircs_swrs', 'emission', 'unit_id', 'bigint', 'emission.unit_id column should be type bigint');
select col_is_null(      'ggircs_swrs', 'emission', 'unit_id', 'emission.unit_id column should allow null');
select col_hasnt_default('ggircs_swrs', 'emission', 'unit_id', 'emission.unit_id column should not  have a default');

select * from finish();
rollback;
