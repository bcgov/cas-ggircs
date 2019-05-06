set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(29);

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
    'process_idx'::name,
    'sub_process_idx'::name,
    'units_idx'::name,
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

insert into ggircs_swrs.ghgr_import (xml_file) values ($$
  <ActivityData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ActivityPages>
      <Process ProcessName="ElectricityGeneration">
        <SubProcess SubprocessName="Emissions from fuel combustion for electricity generation" InformationRequirement="Required">
          <Units UnitType="Non-Cogen Units">
            <Unit>
              <NonCOGenUnit>
                <NonCogenUnitName>Generator #1</NonCogenUnitName>
                <NameplateCapacity>8.44</NameplateCapacity>
                <NetPower>9636</NetPower>
              </NonCOGenUnit>
              <Fuels>
                <Fuel>
                  <FuelType>Natural Gas (Sm^3)</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelUnits>Sm^3</FuelUnits>
                  <AnnualFuelAmount>4550520</AnnualFuelAmount>
                  <AnnualWeightedAverageHighHeatingValue>0.0369</AnnualWeightedAverageHighHeatingValue>
                  <AnnualWeightedAverageCarbonContent>0.7192</AnnualWeightedAverageCarbonContent>
                  <MeasuredEmissionFactors/>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
      </Process>
    </ActivityPages>
  </ActivityData>$$);

-- idx integer not null path 'count(./preceding-sibling::Fuel)',
-- activity_idx integer not null path 'count(./ancestor::Unit/preceding-sibling::Unit)',
-- unit_idx integer not null path 'count(./ancestor::Unit/preceding-sibling::Unit)',

refresh materialized view ggircs_swrs.fuel with data;
refresh materialized view ggircs_swrs.unit with data;
-- test foreign keys
select results_eq(
  'select distinct ghgr_import_id from ggircs_swrs.fuel',
  'select id from ggircs_swrs.ghgr_import',
  'ggircs_swrs.fuel.ghgr_import_id relates to ggircs_swrs.ghgr_import.id'
);

select results_eq(
    'select unit.ghgr_import_id from ggircs_swrs.fuel ' ||
    'join ggircs_swrs.unit ' ||
    'on (' ||
    'fuel.ghgr_import_id =  unit.ghgr_import_id ' ||
    'and fuel.process_idx = unit.process_idx ' ||
    'and fuel.sub_process_idx = unit.sub_process_idx ' ||
    'and fuel.activity_name = unit.activity_name ' ||
    'and fuel.units_idx = unit.units_idx ' ||
    'and fuel.unit_idx = unit.unit_idx)',

    'select ghgr_import_id from ggircs_swrs.unit',

    'Foreign keys ghgr_import_id, process_idx, sub_process_idx, activity_name, units_idx and unit_idx in ggircs_swrs_fuel reference ggircs_swrs.unit'
);



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
