set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

select plan(116);


select has_materialized_view(
    'swrs_transform', 'fuel',
    'swrs_transform.fuel should be a materialized view'
);

select has_index(
    'swrs_transform', 'fuel', 'ggircs_fuel_primary_key',
    'swrs_transform.fuel should have a primary key'
);

select columns_are('swrs_transform'::name, 'fuel'::name, array[
    'id'::name,
    'ghgr_import_id'::name,
    'activity_name'::name,
    'sub_activity_name'::name,
    'unit_name'::name,
    'sub_unit_name'::name,
    'process_idx'::name,
    'sub_process_idx'::name,
    'units_idx'::name,
    'unit_idx'::name,
    'substances_idx'::name,
    'substance_idx'::name,
    'fuel_idx'::name,
    'fuel_type'::name,
    'fuel_classification'::name,
    'fuel_description'::name,
    'fuel_units'::name,
    'annual_fuel_amount'::name,
    'annual_weighted_avg_carbon_content'::name,
    'annual_weighted_avg_hhv'::name,
    'annual_steam_generation'::name,
    'alternative_methodology_description'::name,
    'other_flare_details'::name,
    'q1'::name,
    'q2'::name,
    'q3'::name,
    'q4'::name,
    'wastewater_processing_factors'::name,
    'measured_conversion_factors'::name

]);


--  select has_column(       'swrs_transform', 'fuel', 'ghgr_import_id', 'fuel.ghgr_import_id column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'ghgr_import_id', 'integer', 'fuel.ghgr_import_id column should be type integer');
select col_hasnt_default('swrs_transform', 'fuel', 'ghgr_import_id', 'fuel.ghgr_import_id column should not have a default value');


--  select has_column(       'swrs_transform', 'fuel', 'activity_name', 'fuel.activity_id column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'activity_name', 'character varying(1000)', 'fuel.activity_name column should be type varchar');
select col_is_null(      'swrs_transform', 'fuel', 'activity_name', 'fuel.activity_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'activity_name', 'fuel.activity_idx column should not have a default');

--  select has_column(       'swrs_transform', 'fuel', 'sub_activity_name', 'fuel.activity_id column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'sub_activity_name', 'character varying(1000)', 'fuel.sub_activity_name column should be type varchar');
select col_is_null(      'swrs_transform', 'fuel', 'sub_activity_name', 'fuel.activity_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'sub_activity_name', 'fuel.activity_idx column should not have a default');

--  select has_column(       'swrs_transform', 'fuel', 'unit_name', 'fuel.activity_id column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'unit_name', 'character varying(1000)', 'fuel.unit_name column should be type varchar');
select col_is_null(      'swrs_transform', 'fuel', 'unit_name', 'fuel.activity_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'unit_name', 'fuel.activity_idx column should not have a default');

--  select has_column(       'swrs_transform', 'fuel', 'sub_unit_name', 'fuel.activity_id column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'sub_unit_name', 'character varying(1000)', 'fuel.sub_unit_name column should be type varchar');
select col_is_null(      'swrs_transform', 'fuel', 'sub_unit_name', 'fuel.activity_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'sub_unit_name', 'fuel.activity_idx column should not have a default');

--  select has_column(       'swrs_transform', 'fuel', 'process_idx', 'fuel.process_idx column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'process_idx', 'integer', 'fuel.process_idx column should be type integer');
select col_is_null(      'swrs_transform', 'fuel', 'process_idx', 'fuel.process_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'process_idx', 'fuel.process_idx column should not  have a default');

--  select has_column(       'swrs_transform', 'fuel', 'sub_process_idx', 'fuel.sub_process_idx column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'sub_process_idx', 'integer', 'fuel.sub_process_idx column should be type integer');
select col_is_null(      'swrs_transform', 'fuel', 'sub_process_idx', 'fuel.sub_process_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'sub_process_idx', 'fuel.sub_process_idx column should not  have a default');

--  select has_column(       'swrs_transform', 'fuel', 'units_idx', 'fuel.units_idx column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'units_idx', 'integer', 'fuel.units_idx column should be type integer');
select col_is_null(      'swrs_transform', 'fuel', 'units_idx', 'fuel.units_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'units_idx', 'fuel.units_idx column should not  have a default');

--  select has_column(       'swrs_transform', 'fuel', 'unit_idx', 'fuel.unit_idx column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'unit_idx', 'integer', 'fuel.unit_idx column should be type integer');
select col_is_null(      'swrs_transform', 'fuel', 'unit_idx', 'fuel.unit_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'unit_idx', 'fuel.unit_idx column should not  have a default');

--  select has_column(       'swrs_transform', 'fuel', 'substances_idx', 'fuel.substances_idx column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'substances_idx', 'integer', 'fuel.substances_idx column should be type integer');
select col_is_null(      'swrs_transform', 'fuel', 'substances_idx', 'fuel.substances_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'substances_idx', 'fuel.substances_idx column should not  have a default');

--  select has_column(       'swrs_transform', 'fuel', 'substance_idx', 'fuel.substance_idx column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'substance_idx', 'integer', 'fuel.substance_idx column should be type integer');
select col_is_null(      'swrs_transform', 'fuel', 'substance_idx', 'fuel.substance_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'substance_idx', 'fuel.substance_idx column should not  have a default');

--  select has_column(       'swrs_transform', 'fuel', 'fuel_idx', 'fuel.fuel_idx column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'fuel_idx', 'integer', 'fuel.fuel_idx column should be type integer');
select col_is_null(      'swrs_transform', 'fuel', 'fuel_idx', 'fuel.fuel_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'fuel_idx', 'fuel.fuel_idx column should not  have a default');


--  select has_column(       'swrs_transform', 'fuel', 'fuel_type', 'fuel.fuel_type column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'fuel_type', 'character varying(1000)', 'fuel.fuel_type column should be type varchar');
select col_is_null(      'swrs_transform', 'fuel', 'fuel_type', 'fuel.fuel_type column should allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'fuel_type', 'fuel.fuel_type column should not  have a default');

--  select has_column(       'swrs_transform', 'fuel', 'fuel_classification', 'fuel.fuel_classification column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'fuel_classification', 'character varying(1000)', 'fuel.fuel_classification column should be type varchar');
select col_is_null(      'swrs_transform', 'fuel', 'fuel_classification', 'fuel.fuel_classification column should allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'fuel_classification', 'fuel.fuel_classification column should not  have a default');


--  select has_column(       'swrs_transform', 'fuel', 'fuel_description', 'fuel.fuel_description column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'fuel_description', 'character varying(1000)', 'fuel.fuel_description column should be type varchar');
select col_is_null(      'swrs_transform', 'fuel', 'fuel_description', 'fuel.fuel_description column should allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'fuel_description', 'fuel.fuel_description column should not  have a default');

--  select has_column(       'swrs_transform', 'fuel', 'fuel_units', 'fuel.fuel_units column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'fuel_units', 'character varying(1000)', 'fuel.fuel_units column should be type varchar');
select col_is_null(      'swrs_transform', 'fuel', 'fuel_units', 'fuel.units column should allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'fuel_units', 'fuel.units column should not  have a default');

--  select has_column(       'swrs_transform', 'fuel', 'annual_fuel_amount', 'fuel.annual_fuel_amount column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'annual_fuel_amount', 'numeric', 'fuel.annual_fuel_amount column should be type numeric');
select col_is_null(      'swrs_transform', 'fuel', 'annual_fuel_amount', 'fuel.units column should allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'annual_fuel_amount', 'fuel.units column should not  have a default');

--  select has_column(       'swrs_transform', 'fuel', 'annual_weighted_avg_carbon_content', 'fuel.annual_weighted_avg_carbon_content column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'annual_weighted_avg_carbon_content', 'numeric', 'fuel.annual_weighted_avg_carbon_content column should be type numeric');
select col_is_null(      'swrs_transform', 'fuel', 'annual_weighted_avg_carbon_content', 'fuel.annual_weighted_avg_carbon_content column should allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'annual_weighted_avg_carbon_content', 'fuel.annual_weighted_avg_carbon_content column should not  have a default');


--  select has_column(       'swrs_transform', 'fuel', 'annual_weighted_avg_hhv', 'fuel.annual_weighted_avg_hhv column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'annual_weighted_avg_hhv', 'numeric', 'fuel.annual_weighted_avg_hhv column should be type numeric');
select col_is_null(      'swrs_transform', 'fuel', 'annual_weighted_avg_hhv', 'fuel.units column should allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'annual_weighted_avg_hhv', 'fuel.units column should not  have a default');


--  select has_column(       'swrs_transform', 'fuel', 'annual_steam_generation', 'fuel.annual_steam_generation column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'annual_steam_generation', 'numeric', 'fuel.annual_steam_generation column should be type numeric');
select col_is_null(      'swrs_transform', 'fuel', 'annual_steam_generation', 'fuel.annual_steam_generation column should allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'annual_steam_generation', 'fuel.annual_steam_generation column should not  have a default');

--  select has_column(       'swrs_transform', 'fuel', 'alternative_methodology_description', 'fuel.alternative_methodology_description column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'alternative_methodology_description', 'character varying(10000)', 'fuel.alternative_methodology_description column should be type varchar');
select col_is_null(      'swrs_transform', 'fuel', 'alternative_methodology_description', 'fuel.alternative_methodology_description column should allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'alternative_methodology_description', 'fuel.alternative_methodology_description column should not  have a default');

--  select has_column(       'swrs_transform', 'fuel', 'other_flare_details', 'fuel.other_flare_details column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'other_flare_details', 'character varying(1000)', 'fuel.other_flare_details column should be type varchar');
select col_is_null(      'swrs_transform', 'fuel', 'other_flare_details', 'fuel.other_flare_details column should allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'other_flare_details', 'fuel.other_flare_details column should not  have a default');

--  select has_column(       'swrs_transform', 'fuel', 'q1', 'fuel.q1 column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'q1', 'numeric', 'fuel.q1 column should be type numeric');
select col_is_null(      'swrs_transform', 'fuel', 'q1', 'fuel.q1 column should allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'q1', 'fuel.q1 column should not  have a default');

--  select has_column(       'swrs_transform', 'fuel', 'q2', 'fuel.q2 column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'q2', 'numeric', 'fuel.q2 column should be type numeric');
select col_is_null(      'swrs_transform', 'fuel', 'q2', 'fuel.q2 column should allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'q2', 'fuel.q2 column should not  have a default');

--  select has_column(       'swrs_transform', 'fuel', 'q3', 'fuel.q3 column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'q3', 'numeric', 'fuel.q3 column should be type numeric');
select col_is_null(      'swrs_transform', 'fuel', 'q3', 'fuel.q3 column should allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'q3', 'fuel.q3 column should not  have a default');

--  select has_column(       'swrs_transform', 'fuel', 'q4', 'fuel.q4 column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'q4', 'numeric', 'fuel.q4 column should be type numeric');
select col_is_null(      'swrs_transform', 'fuel', 'q4', 'fuel.q4 column should allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'q4', 'fuel.q4 column should not  have a default');

--  select has_column(       'swrs_transform', 'fuel', 'wastewater_processing_factors', 'fuel.wastewater_processing_factors column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'wastewater_processing_factors', 'xml', 'fuel.wastewater_processing_factors column should be type xml');
select col_is_null(      'swrs_transform', 'fuel', 'wastewater_processing_factors', 'fuel.wastewater_processing_factors column should allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'wastewater_processing_factors', 'fuel.wastewater_processing_factors column should not  have a default');

--  select has_column(       'swrs_transform', 'fuel', 'measured_conversion_factors', 'fuel.measured_conversion_factors column should exist');
select col_type_is(      'swrs_transform', 'fuel', 'measured_conversion_factors', 'xml', 'fuel.measured_conversion_factors column should be type xml');
select col_is_null(      'swrs_transform', 'fuel', 'measured_conversion_factors', 'fuel.measured_conversion_factors column should allow null');
select col_hasnt_default('swrs_transform', 'fuel', 'measured_conversion_factors', 'fuel.measured_conversion_factors column should not  have a default');



insert into swrs_extract.ghgr_import (xml_file) values ($$
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
                  <FuelDescription/>
                  <FuelUnits>Sm^3</FuelUnits>
                  <AnnualFuelAmount>4550520</AnnualFuelAmount>
                  <AnnualWeightedAverageHighHeatingValue>0.0369</AnnualWeightedAverageHighHeatingValue>
                  <AnnualWeightedAverageCarbonContent>0.7192</AnnualWeightedAverageCarbonContent>
                  <AnnualSteamGeneration>.6</AnnualSteamGeneration>
                  <AlternativeMethodologyDescription>wordswordswords</AlternativeMethodologyDescription>
                  <MeasuredEmissionFactor>1</MeasuredEmissionFactor>
                  <MeasuredEmissionFactorUnitType>red</MeasuredEmissionFactorUnitType>
                  <OtherFlareDetails>flare!</OtherFlareDetails>
                  <Q1>1</Q1>
                  <Q2></Q2>
                  <Q3/>
                  <Q4>4</Q4>
                  <MeasuredEmissionFactors/>
                  <WastewaterProcessingFactors/>
                  <MeasuredConversionFactors/>
                </Fuel>
              </Fuels>
            </Unit>
            <Unit>
              <Fuels>
                <Fuel>
                  <FuelType>test</FuelType>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
      </Process>
    </ActivityPages>
  </ActivityData>$$);

refresh materialized view swrs_transform.fuel with data;
refresh materialized view swrs_transform.unit with data;

-- test foreign keys
select results_eq(
  'select distinct ghgr_import_id from swrs_transform.fuel',
  'select id from swrs_extract.ghgr_import',
  'swrs_transform.fuel.ghgr_import_id relates to swrs_extract.ghgr_import.id'
);

select results_eq(
    $$
    select unit.ghgr_import_id from swrs_transform.fuel
    join swrs_transform.unit
    on (
    fuel.ghgr_import_id =  unit.ghgr_import_id
    and fuel.process_idx = unit.process_idx
    and fuel.sub_process_idx = unit.sub_process_idx
    and fuel.activity_name = unit.activity_name
    and fuel.units_idx = unit.units_idx
    and fuel.unit_idx = unit.unit_idx)
    $$,

    'select ghgr_import_id from swrs_transform.unit',

    'Foreign keys ghgr_import_id, process_idx, sub_process_idx, activity_name, units_idx and unit_idx in ggircs_swrs_fuel reference swrs_transform.unit'
);

-- Test xml column parsing
select results_eq(
    'select ghgr_import_id from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    'select id from swrs_extract.ghgr_import',
    'column ghgr_import_id in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select activity_name from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY['ActivityPages'::varchar],
    'column activity_name in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select sub_activity_name from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY['Process'::varchar],
    'column sub_activity_name in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select unit_name from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY[''::varchar],
    'column unit_name in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select sub_unit_name from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY[''::varchar],
    'column sub_unit_name in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select process_idx from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY[0::integer],
    'column process_idx in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select sub_process_idx from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY[0::integer],
    'column sub_process_idx in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select units_idx from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY[0::integer],
    'column unit_idx in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select unit_idx from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY[0::integer],
    'column units_idx in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select substances_idx from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY[0::integer],
    'column substances_idx in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select substance_idx from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY[0::integer],
    'column substance_idx in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select fuel_idx from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY[0::integer],
    'column fuel_idx in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select fuel_type from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY['Natural Gas (Sm^3)'::varchar],
    'column fuel_type in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select fuel_classification from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY['non-biomass'::varchar],
    'column fuel_classification in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select fuel_description from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY[''::varchar],
    'column fuel_description in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select fuel_units from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY['Sm^3'::varchar],
    'column fuel_units in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select annual_fuel_amount from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY['4550520'::numeric],
    'column annual_fuel_amount in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select annual_weighted_avg_hhv from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY['0.0369'::numeric],
    'column annual_weighted_avg_hhv in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select annual_weighted_avg_carbon_content from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY['0.7192'::numeric],
    'column annual_weighted_avg_carbon_content in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select annual_steam_generation from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY['.6'::numeric],
    'column annual_steam_generation in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select alternative_methodology_description from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY['wordswordswords'::varchar],
    'column alternative_methodology_description in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select other_flare_details from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY['flare!'::varchar],
    'column other_flare_details in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select q1 from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY[1::numeric],
    'column q1 in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select q2 from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY[null::numeric],
    'column q2 in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select q3 from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY[null::numeric],
    'column q3 in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select q4 from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY['4'::numeric],
    'column q4 in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select wastewater_processing_factors::text from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY['<WastewaterProcessingFactors/>'::text],
    'column wastewater_processing_factors in swrs_transform.fuel was properly parsed from xml'
);

select results_eq(
    'select measured_conversion_factors::text from swrs_transform.fuel where fuel_idx=0 and unit_idx=0',
    ARRAY['<MeasuredConversionFactors/>'::text],
    'column measured_conversion_factors in swrs_transform.fuel was properly parsed from xml'
);

select * from finish();

rollback;
