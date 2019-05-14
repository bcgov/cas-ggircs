set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

select plan(39);

select has_materialized_view(
    'ggircs_swrs', 'measured_emission_factor',
    'ggircs_swrs.measured_emission_factor should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'measured_emission_factor', 'ggircs_measured_emission_factor_primary_key',
    'ggircs_swrs.measured_emission_factor should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'measured_emission_factor'::name, array[

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
    'measured_emission_factor_idx'::name,
    'measured_emission_factor_amount'::name,
    'measured_emission_factor_gas'::name,
    'measured_emission_factor_unit_type'::name
]);


--  select has_column(       'ggircs_swrs', 'measured_emission_factor', 'ghgr_import_id', 'measured_emission_factor.ghgr_import_id column should exist');
select col_type_is(      'ggircs_swrs', 'measured_emission_factor', 'ghgr_import_id', 'integer', 'measured_emission_factor.ghgr_import_id column should be type integer');
select col_hasnt_default('ggircs_swrs', 'measured_emission_factor', 'ghgr_import_id', 'measured_emission_factor.ghgr_import_id column should not have a default value');

--  select has_column(       'ggircs_swrs', 'measured_emission_factor', 'activity_name', 'measured_emission_factor.activity_id column should exist');
select col_type_is(      'ggircs_swrs', 'measured_emission_factor', 'activity_name', 'character varying(1000)', 'measured_emission_factor.activity_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'measured_emission_factor', 'activity_name', 'measured_emission_factor.activity_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'measured_emission_factor', 'activity_name', 'measured_emission_factor.activity_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'measured_emission_factor', 'sub_activity_name', 'measured_emission_factor.activity_id column should exist');
select col_type_is(      'ggircs_swrs', 'measured_emission_factor', 'sub_activity_name', 'character varying(1000)', 'measured_emission_factor.sub_activity_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'measured_emission_factor', 'sub_activity_name', 'measured_emission_factor.activity_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'measured_emission_factor', 'sub_activity_name', 'measured_emission_factor.activity_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'measured_emission_factor', 'unit_name', 'measured_emission_factor.activity_id column should exist');
select col_type_is(      'ggircs_swrs', 'measured_emission_factor', 'unit_name', 'character varying(1000)', 'measured_emission_factor.unit_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'measured_emission_factor', 'unit_name', 'measured_emission_factor.activity_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'measured_emission_factor', 'unit_name', 'measured_emission_factor.activity_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'measured_emission_factor', 'sub_unit_name', 'measured_emission_factor.activity_id column should exist');
select col_type_is(      'ggircs_swrs', 'measured_emission_factor', 'sub_unit_name', 'character varying(1000)', 'measured_emission_factor.sub_unit_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'measured_emission_factor', 'sub_unit_name', 'measured_emission_factor.activity_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'measured_emission_factor', 'sub_unit_name', 'measured_emission_factor.activity_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'measured_emission_factor', 'process_idx', 'measured_emission_factor.process_idx column should exist');
select col_type_is(      'ggircs_swrs', 'measured_emission_factor', 'process_idx', 'integer', 'measured_emission_factor.process_idx column should be type integer');
select col_is_null(      'ggircs_swrs', 'measured_emission_factor', 'process_idx', 'measured_emission_factor.process_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'measured_emission_factor', 'process_idx', 'measured_emission_factor.process_idx column should not  have a default');

--  select has_column(       'ggircs_swrs', 'measured_emission_factor', 'sub_process_idx', 'measured_emission_factor.sub_process_idx column should exist');
select col_type_is(      'ggircs_swrs', 'measured_emission_factor', 'sub_process_idx', 'integer', 'measured_emission_factor.sub_process_idx column should be type integer');
select col_is_null(      'ggircs_swrs', 'measured_emission_factor', 'sub_process_idx', 'measured_emission_factor.sub_process_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'measured_emission_factor', 'sub_process_idx', 'measured_emission_factor.sub_process_idx column should not  have a default');

--  select has_column(       'ggircs_swrs', 'measured_emission_factor', 'units_idx', 'measured_emission_factor.units_idx column should exist');
select col_type_is(      'ggircs_swrs', 'measured_emission_factor', 'units_idx', 'integer', 'measured_emission_factor.units_idx column should be type integer');
select col_is_null(      'ggircs_swrs', 'measured_emission_factor', 'units_idx', 'measured_emission_factor.units_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'measured_emission_factor', 'units_idx', 'measured_emission_factor.units_idx column should not  have a default');

--  select has_column(       'ggircs_swrs', 'measured_emission_factor', 'unit_idx', 'measured_emission_factor.unit_idx column should exist');
select col_type_is(      'ggircs_swrs', 'measured_emission_factor', 'unit_idx', 'integer', 'measured_emission_factor.unit_idx column should be type integer');
select col_is_null(      'ggircs_swrs', 'measured_emission_factor', 'unit_idx', 'measured_emission_factor.unit_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'measured_emission_factor', 'unit_idx', 'measured_emission_factor.unit_idx column should not  have a default');

--  select has_column(       'ggircs_swrs', 'measured_emission_factor', 'substances_idx', 'measured_emission_factor.substances_idx column should exist');
select col_type_is(      'ggircs_swrs', 'measured_emission_factor', 'substances_idx', 'integer', 'measured_emission_factor.substances_idx column should be type integer');
select col_is_null(      'ggircs_swrs', 'measured_emission_factor', 'substances_idx', 'measured_emission_factor.substances_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'measured_emission_factor', 'substances_idx', 'measured_emission_factor.substances_idx column should not  have a default');

--  select has_column(       'ggircs_swrs', 'measured_emission_factor', 'substance_idx', 'measured_emission_factor.substance_idx column should exist');
select col_type_is(      'ggircs_swrs', 'measured_emission_factor', 'substance_idx', 'integer', 'measured_emission_factor.substance_idx column should be type integer');
select col_is_null(      'ggircs_swrs', 'measured_emission_factor', 'substance_idx', 'measured_emission_factor.substance_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'measured_emission_factor', 'substance_idx', 'measured_emission_factor.substance_idx column should not  have a default');

--  select has_column(       'ggircs_swrs', 'measured_emission_factor', 'fuel_idx', 'measured_emission_factor.fuel_idx column should exist');
select col_type_is(      'ggircs_swrs', 'measured_emission_factor', 'fuel_idx', 'integer', 'measured_emission_factor.fuel_idx column should be type integer');
select col_is_null(      'ggircs_swrs', 'measured_emission_factor', 'fuel_idx', 'measured_emission_factor.fuel_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'measured_emission_factor', 'fuel_idx', 'measured_emission_factor.fuel_idx column should not  have a default');

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
                  <MeasuredEmissionFactors>
                    <MeasuredEmissionFactor>
                    
                    </MeasuredEmissionFactor>
                  </MeasuredEmissionFactors>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
      </Process>
    </ActivityPages>
  </ActivityData>$$);

refresh materialized view ggircs_swrs.fuel with data;
refresh materialized view ggircs_swrs.measured_emission_factor with data;

-- test foreign keys
select results_eq(
  'select distinct ghgr_import_id from ggircs_swrs.measured_emission_factor',
  'select id from ggircs_swrs.ghgr_import',
  'ggircs_swrs.measured_emission_factor.ghgr_import_id relates to ggircs_swrs.ghgr_import.id'
);

-- select results_eq(
--     'select unit.ghgr_import_id from ggircs_swrs.fuel ' ||
--     'join ggircs_swrs.unit ' ||
--     'on (' ||
--     'fuel.ghgr_import_id =  unit.ghgr_import_id ' ||
--     'and fuel.process_idx = unit.process_idx ' ||
--     'and fuel.sub_process_idx = unit.sub_process_idx ' ||
--     'and fuel.activity_name = unit.activity_name ' ||
--     'and fuel.units_idx = unit.units_idx ' ||
--     'and fuel.unit_idx = unit.unit_idx)',
--
--     'select ghgr_import_id from ggircs_swrs.unit',
--
--     'Foreign keys ghgr_import_id, process_idx, sub_process_idx, activity_name, units_idx and unit_idx in ggircs_swrs_fuel reference ggircs_swrs.unit'
-- );

select * from finish();

rollback;
