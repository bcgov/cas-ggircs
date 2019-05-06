set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(27);

select has_materialized_view(
    'ggircs_swrs', 'fuel',
    'ggircs_swrs.fuel should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'fuel', 'ggircs_fuel_primary_key',
    'ggircs_swrs.fuel should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'fuel'::name, array[
    'idx'::name,
    'ghgr_import_id'::name,
    'activity_name'::name,
    'unit_idx'::name,
    'fuel_type'::name,
    'fuel_classification'::name,
    'fuel_units'::name,
    'annual_fuel_amount'::name,
    'annual_weighted_avg_hhv'::name
]);

--  select has_column(       'ggircs_swrs', 'fuel', 'id', 'fuel.id column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'idx', 'integer', 'fuel.idx column should be type integer');

--  select has_column(       'ggircs_swrs', 'fuel', 'ghgr_import_id', 'fuel.ghgr_import_id column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'ghgr_import_id', 'integer', 'fuel.ghgr_import_id column should be type integer');
select col_hasnt_default('ggircs_swrs', 'fuel', 'ghgr_import_id', 'fuel.ghgr_import_id column should not have a default value');

--  select has_column(       'ggircs_swrs', 'fuel', 'activity_name', 'fuel.activity_id column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'activity_name', 'character varying(1000)', 'fuel.activity_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'fuel', 'activity_name', 'fuel.activity_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'fuel', 'activity_name', 'fuel.activity_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'fuel', 'unit_idx', 'fuel.unit_idx column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'unit_idx', 'integer', 'fuel.unit_idx column should be type integer');
select col_is_null(      'ggircs_swrs', 'fuel', 'unit_idx', 'fuel.unit_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'fuel', 'unit_idx', 'fuel.unit_idx column should not  have a default');

--  select has_column(       'ggircs_swrs', 'fuel', 'fuel_type', 'fuel.fuel_type column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'fuel_type', 'character varying(1000)', 'fuel.fuel_type column should be type varchar');
select col_is_null(      'ggircs_swrs', 'fuel', 'fuel_type', 'fuel.fuel_type column should allow null');
select col_hasnt_default('ggircs_swrs', 'fuel', 'fuel_type', 'fuel.fuel_type column should not  have a default');

--  select has_column(       'ggircs_swrs', 'fuel', 'fuel_classification', 'fuel.fuel_classification column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'fuel_classification', 'character varying(1000)', 'fuel.fuel_classification column should be type varchar');
select col_is_null(      'ggircs_swrs', 'fuel', 'fuel_classification', 'fuel.fuel_classification column should allow null');
select col_hasnt_default('ggircs_swrs', 'fuel', 'fuel_classification', 'fuel.fuel_classification column should not  have a default');

--  select has_column(       'ggircs_swrs', 'fuel', 'fuel_units', 'fuel.fuel_units column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'fuel_units', 'character varying(1000)', 'fuel.fuel_units column should be type varchar');
select col_is_null(      'ggircs_swrs', 'fuel', 'fuel_units', 'fuel.units column should allow null');
select col_hasnt_default('ggircs_swrs', 'fuel', 'fuel_units', 'fuel.units column should not  have a default');

--  select has_column(       'ggircs_swrs', 'fuel', 'annual_fuel_amount', 'fuel.annual_fuel_amount column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'annual_fuel_amount', 'character varying(1000)', 'fuel.annual_fuel_amount column should be type varchar');
select col_is_null(      'ggircs_swrs', 'fuel', 'annual_fuel_amount', 'fuel.units column should allow null');
select col_hasnt_default('ggircs_swrs', 'fuel', 'annual_fuel_amount', 'fuel.units column should not  have a default');

--  select has_column(       'ggircs_swrs', 'fuel', 'annual_weighted_avg_hhv', 'fuel.annual_weighted_avg_hhv column should exist');
select col_type_is(      'ggircs_swrs', 'fuel', 'annual_weighted_avg_hhv', 'character varying(1000)', 'fuel.annual_weighted_avg_hhv column should be type varchar');
select col_is_null(      'ggircs_swrs', 'fuel', 'annual_weighted_avg_hhv', 'fuel.units column should allow null');
select col_hasnt_default('ggircs_swrs', 'fuel', 'annual_weighted_avg_hhv', 'fuel.units column should not  have a default');

-- TODO(wenzowski): check foreign key references
-- idx integer not null path 'count(./preceding-sibling::Fuel)',
-- activity_idx integer not null path 'count(./ancestor::Unit/preceding-sibling::Unit)',
-- unit_idx integer not null path 'count(./ancestor::Unit/preceding-sibling::Unit)',

-- TODO(wenzowski): ensure all descriptors are extracted
-- with x as (select id, xml_hunk from ggircs_swrs.fuel)
-- select distinct tags.name
-- from x,
--      xmltable('/Fuel/*' passing xml_hunk columns name text path 'name(.)') as tags
-- order by tags.name;

-- AlternativeMethodologyDescription
-- AnnualFuelAmount
-- AnnualSteamGeneration
-- AnnualWeightedAverageCarbonContent
-- AnnualWeightedAverageHighHeatingValue
-- Emissions
-- FuelClassification
-- FuelDescription
-- FuelType
-- FuelUnits
-- MeasuredConversionFactors
-- MeasuredEmissionFactor
-- MeasuredEmissionFactorUnitType
-- MeasuredEmissionFactors
-- OtherFlareDetails
-- Q1
-- Q2
-- Q3
-- Q4
-- WastewaterProcessingFactors

select * from finish();
rollback;
