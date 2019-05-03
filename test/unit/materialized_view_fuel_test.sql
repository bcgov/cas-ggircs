set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(24);

select has_materialized_view(
    'ggircs_swrs', 'fuel',
    'ggircs_swrs.fuel should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'fuel', 'ggircs_fuel_primary_key',
    'ggircs_swrs.fuel should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'fuel'::name, array[
    'id'::name,
    'ghgr_import_id'::name,
    'activity_id'::name,
    'activity'::name,
    'sub_activity'::name,
    'unit_name'::name,
    'unit_id'::name,
    'fuel_type'::name,
    'fuel_classification'::name,
    'fuel_units'::name,
    'annual_fuel_amount'::name,
    'annual_weighted_avg_hhv'::name,
    'fuel_xml_hunk'::name
]);

--  select has_column(       'ggircs_swrs', 'fuel', 'id', 'fuel.id column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'id', 'bigint', 'fuel.id column should be type bigint');

--  select has_column(       'ggircs_swrs', 'fuel', 'ghgr_import_id', 'fuel.ghgr_import_id column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'ghgr_import_id', 'integer', 'fuel.ghgr_import_id column should be type integer');
select col_hasnt_default('ggircs_swrs', 'fuel', 'ghgr_import_id', 'fuel.ghgr_import_id column should not have a default value');

--  select has_column(       'ggircs_swrs', 'fuel', 'activity_id', 'fuel.activity_id column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'activity_id', 'numeric(1000,0)', 'fuel.activity_id column should be type numeric');
select col_is_null(      'ggircs_swrs', 'fuel', 'activity_id', 'fuel.activity_id column should allow null');
select col_hasnt_default('ggircs_swrs', 'fuel', 'activity_id', 'fuel.activity_id column should not  have a default');

--  select has_column(       'ggircs_swrs', 'fuel', 'activity', 'fuel.activity_id column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'activity', 'character varying(1000)', 'fuel.activity_id column should be type varchar');
select col_is_null(      'ggircs_swrs', 'fuel', 'activity', 'fuel.activity_id column should allow null');
select col_hasnt_default('ggircs_swrs', 'fuel', 'activity', 'fuel.activity_id column should not  have a default');

--  select has_column(       'ggircs_swrs', 'fuel', 'sub_activity', 'fuel.activity_id column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'sub_activity', 'character varying(1000)', 'fuel.sub_activity column should be type varchar');
select col_is_null(      'ggircs_swrs', 'fuel', 'sub_activity', 'fuel.sub_activity column should allow null');
select col_hasnt_default('ggircs_swrs', 'fuel', 'sub_activity', 'fuel.sub_activity column should not  have a default');

--  select has_column(       'ggircs_swrs', 'fuel', 'unit_name', 'fuel.activity_id column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'unit_name', 'character varying(1000)', 'fuel.unit_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'fuel', 'unit_name', 'fuel.activity_id column should allow null');
select col_hasnt_default('ggircs_swrs', 'fuel', 'unit_name', 'fuel.activity_id column should not  have a default');

--  select has_column(       'ggircs_swrs', 'fuel', 'unit_id', 'fuel.unit_id column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'unit_id', 'numeric(1000,0)', 'fuel.unit_id column should be type text');
select col_is_null(      'ggircs_swrs', 'fuel', 'unit_id', 'fuel.unit_id column should allow null');
select col_hasnt_default('ggircs_swrs', 'fuel', 'unit_id', 'fuel.unit_id column should not  have a default');

--  select has_column(       'ggircs_swrs', 'fuel', 'fuel_type', 'fuel.activity_id column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'fuel_type', 'character varying(1000)', 'fuel.fuel_type column should be type varchar');
select col_is_null(      'ggircs_swrs', 'fuel', 'fuel_type', 'fuel.fuel_type column should allow null');
select col_hasnt_default('ggircs_swrs', 'fuel', 'fuel_type', 'fuel.fuel_type column should not  have a default');

--  select has_column(       'ggircs_swrs', 'fuel', 'fuel_classification', 'fuel.activity_id column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'fuel_classification', 'character varying(1000)', 'fuel.fuel_classification column should be type varchar');
select col_is_null(      'ggircs_swrs', 'fuel', 'fuel_classification', 'fuel.fuel_classification column should allow null');
select col_hasnt_default('ggircs_swrs', 'fuel', 'fuel_classification', 'fuel.fuel_classification column should not  have a default');

--  select has_column(       'ggircs_swrs', 'fuel', 'fuel_units', 'fuel.activity_id column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'fuel_units', 'character varying(1000)', 'fuel.fuel_units column should be type varchar');
select col_is_null(      'ggircs_swrs', 'fuel', 'fuel_units', 'fuel.units column should allow null');
select col_hasnt_default('ggircs_swrs', 'fuel', 'fuel_units', 'fuel.units column should not  have a default');

--  select has_column(       'ggircs_swrs', 'fuel', 'annual_fuel_amount', 'fuel.activity_id column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'annual_fuel_amount', 'numeric(1000,0)', 'fuel.annual_fuel_amount column should be type varchar');
select col_is_null(      'ggircs_swrs', 'fuel', 'annual_fuel_amount', 'fuel.units column should allow null');
select col_hasnt_default('ggircs_swrs', 'fuel', 'annual_fuel_amount', 'fuel.units column should not  have a default');

--  select has_column(       'ggircs_swrs', 'fuel', 'annual_weighted_avg_hhv', 'fuel.activity_id column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'annual_weighted_avg_hhv', 'numeric(1000,0)', 'fuel.annual_weighted_avg_hhv column should be type varchar');
select col_is_null(      'ggircs_swrs', 'fuel', 'annual_weighted_avg_hhv', 'fuel.units column should allow null');
select col_hasnt_default('ggircs_swrs', 'fuel', 'annual_weighted_avg_hhv', 'fuel.units column should not  have a default');

select * from finish();
rollback;
