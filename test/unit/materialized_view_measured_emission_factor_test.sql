set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

select plan(37);

select has_materialized_view(
    'swrs_transform', 'measured_emission_factor',
    'swrs_transform.measured_emission_factor should be a materialized view'
);

select has_index(
    'swrs_transform', 'measured_emission_factor', 'ggircs_measured_emission_factor_primary_key',
    'swrs_transform.measured_emission_factor should have a primary key'
);

select columns_are('swrs_transform'::name, 'measured_emission_factor'::name, array[
    'id'::name,
    'eccc_xml_file_id'::name,
    'activity_name'::name,
    'sub_activity_name'::name,
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


--  select has_column(       'swrs_transform', 'measured_emission_factor', 'eccc_xml_file_id', 'measured_emission_factor.eccc_xml_file_id column should exist');
select col_type_is(      'swrs_transform', 'measured_emission_factor', 'eccc_xml_file_id', 'integer', 'measured_emission_factor.eccc_xml_file_id column should be type integer');
select col_hasnt_default('swrs_transform', 'measured_emission_factor', 'eccc_xml_file_id', 'measured_emission_factor.eccc_xml_file_id column should not have a default value');

--  select has_column(       'swrs_transform', 'measured_emission_factor', 'activity_name', 'measured_emission_factor.activity_id column should exist');
select col_type_is(      'swrs_transform', 'measured_emission_factor', 'activity_name', 'character varying(1000)', 'measured_emission_factor.activity_name column should be type varchar');
select col_is_null(      'swrs_transform', 'measured_emission_factor', 'activity_name', 'measured_emission_factor.activity_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'measured_emission_factor', 'activity_name', 'measured_emission_factor.activity_idx column should not have a default');

--  select has_column(       'swrs_transform', 'measured_emission_factor', 'sub_activity_name', 'measured_emission_factor.activity_id column should exist');
select col_type_is(      'swrs_transform', 'measured_emission_factor', 'sub_activity_name', 'character varying(1000)', 'measured_emission_factor.sub_activity_name column should be type varchar');
select col_is_null(      'swrs_transform', 'measured_emission_factor', 'sub_activity_name', 'measured_emission_factor.activity_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'measured_emission_factor', 'sub_activity_name', 'measured_emission_factor.activity_idx column should not have a default');


--  select has_column(       'swrs_transform', 'measured_emission_factor', 'process_idx', 'measured_emission_factor.process_idx column should exist');
select col_type_is(      'swrs_transform', 'measured_emission_factor', 'process_idx', 'integer', 'measured_emission_factor.process_idx column should be type integer');
select col_is_null(      'swrs_transform', 'measured_emission_factor', 'process_idx', 'measured_emission_factor.process_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'measured_emission_factor', 'process_idx', 'measured_emission_factor.process_idx column should not  have a default');

--  select has_column(       'swrs_transform', 'measured_emission_factor', 'sub_process_idx', 'measured_emission_factor.sub_process_idx column should exist');
select col_type_is(      'swrs_transform', 'measured_emission_factor', 'sub_process_idx', 'integer', 'measured_emission_factor.sub_process_idx column should be type integer');
select col_is_null(      'swrs_transform', 'measured_emission_factor', 'sub_process_idx', 'measured_emission_factor.sub_process_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'measured_emission_factor', 'sub_process_idx', 'measured_emission_factor.sub_process_idx column should not  have a default');

--  select has_column(       'swrs_transform', 'measured_emission_factor', 'units_idx', 'measured_emission_factor.units_idx column should exist');
select col_type_is(      'swrs_transform', 'measured_emission_factor', 'units_idx', 'integer', 'measured_emission_factor.units_idx column should be type integer');
select col_is_null(      'swrs_transform', 'measured_emission_factor', 'units_idx', 'measured_emission_factor.units_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'measured_emission_factor', 'units_idx', 'measured_emission_factor.units_idx column should not  have a default');

--  select has_column(       'swrs_transform', 'measured_emission_factor', 'unit_idx', 'measured_emission_factor.unit_idx column should exist');
select col_type_is(      'swrs_transform', 'measured_emission_factor', 'unit_idx', 'integer', 'measured_emission_factor.unit_idx column should be type integer');
select col_is_null(      'swrs_transform', 'measured_emission_factor', 'unit_idx', 'measured_emission_factor.unit_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'measured_emission_factor', 'unit_idx', 'measured_emission_factor.unit_idx column should not  have a default');

--  select has_column(       'swrs_transform', 'measured_emission_factor', 'substances_idx', 'measured_emission_factor.substances_idx column should exist');
select col_type_is(      'swrs_transform', 'measured_emission_factor', 'substances_idx', 'integer', 'measured_emission_factor.substances_idx column should be type integer');
select col_is_null(      'swrs_transform', 'measured_emission_factor', 'substances_idx', 'measured_emission_factor.substances_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'measured_emission_factor', 'substances_idx', 'measured_emission_factor.substances_idx column should not  have a default');

--  select has_column(       'swrs_transform', 'measured_emission_factor', 'substance_idx', 'measured_emission_factor.substance_idx column should exist');
select col_type_is(      'swrs_transform', 'measured_emission_factor', 'substance_idx', 'integer', 'measured_emission_factor.substance_idx column should be type integer');
select col_is_null(      'swrs_transform', 'measured_emission_factor', 'substance_idx', 'measured_emission_factor.substance_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'measured_emission_factor', 'substance_idx', 'measured_emission_factor.substance_idx column should not  have a default');

--  select has_column(       'swrs_transform', 'measured_emission_factor', 'fuel_idx', 'measured_emission_factor.fuel_idx column should exist');
select col_type_is(      'swrs_transform', 'measured_emission_factor', 'fuel_idx', 'integer', 'measured_emission_factor.fuel_idx column should be type integer');
select col_is_null(      'swrs_transform', 'measured_emission_factor', 'fuel_idx', 'measured_emission_factor.fuel_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'measured_emission_factor', 'fuel_idx', 'measured_emission_factor.fuel_idx column should not  have a default');

insert into swrs_extract.eccc_xml_file (xml_file) values ($$
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
                      <MeasuredEmissionFactorAmount>100</MeasuredEmissionFactorAmount>
                      <MeasuredEmissionFactorGas>CO2</MeasuredEmissionFactorGas>
                      <MeasuredEmissionFactorUnitType>g/GJ</MeasuredEmissionFactorUnitType>
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

refresh materialized view swrs_transform.fuel with data;
refresh materialized view swrs_transform.measured_emission_factor with data;

-- test foreign keys
-- measured_emission_factor -> eccc_xml_file
select results_eq(
  'select distinct eccc_xml_file_id from swrs_transform.measured_emission_factor',
  'select id from swrs_extract.eccc_xml_file',
  'swrs_transform.measured_emission_factor.eccc_xml_file_id relates to swrs_extract.eccc_xml_file.id'
);

-- measured_emission_factor -> fuel
select results_eq(
    $$
    select fuel.eccc_xml_file_id from swrs_transform.measured_emission_factor
    join swrs_transform.fuel
    on (
    measured_emission_factor.eccc_xml_file_id =  fuel.eccc_xml_file_id
    and measured_emission_factor.process_idx = fuel.process_idx
    and measured_emission_factor.sub_process_idx = fuel.sub_process_idx
    and measured_emission_factor.activity_name = fuel.activity_name
    and measured_emission_factor.units_idx = fuel.units_idx
    and measured_emission_factor.unit_idx = fuel.unit_idx)
    and measured_emission_factor.fuel_idx = fuel.fuel_idx
    $$,

    'select eccc_xml_file_id from swrs_transform.fuel',

    'Foreign keys eccc_xml_file_id, process_idx, sub_process_idx, activity_name, units_idx, unit_idx and fuel.idx in ggircs_swrs_measured_emission_factor reference swrs_transform.fuel'
);

-- test xml imports
select results_eq(
  'select measured_emission_factor_amount from swrs_transform.measured_emission_factor',
  ARRAY[100::numeric],
  'measured_emission_factor parsed column measured_emission_factor_amount from xml'
);

select results_eq(
  'select measured_emission_factor_gas from swrs_transform.measured_emission_factor',
  ARRAY['CO2'::varchar],
  'measured_emission_factor parsed column measured_emission_factor_gas from xml'
);

select results_eq(
  'select measured_emission_factor_unit_type from swrs_transform.measured_emission_factor',
  ARRAY['g/GJ'::varchar],
  'measured_emission_factor parsed column measured_emission_factor_unit_type from xml'
);

select * from finish();

rollback;
