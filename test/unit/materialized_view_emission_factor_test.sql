set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

select plan(45);

select has_materialized_view(
    'swrs_transform', 'emission_factor',
    'swrs_transform.emission_factor should be a materialized view'
);

select has_index(
    'swrs_transform', 'emission_factor', 'ggircs_emission_factor_primary_key',
    'swrs_transform.emission_factor should have a primary key'
);

select columns_are('swrs_transform'::name, 'emission_factor'::name, array[
    'id'::name,
    'eccc_xml_file_id'::name,
    'activity_name'::name,
    'sub_activity_name'::name,
    'emission_factor_type'::name,
    'default_or_measured'::name,
    'process_idx'::name,
    'sub_process_idx'::name,
    'units_idx'::name,
    'unit_idx'::name,
    'substances_idx'::name,
    'substance_idx'::name,
    'fuel_idx'::name,
    'emission_factor_idx'::name,
    'emission_factor_amount'::name,
    'emission_factor_gas'::name,
    'emission_factor_unit_type'::name
]);

select col_type_is(      'swrs_transform', 'emission_factor', 'eccc_xml_file_id', 'integer', 'emission_factor.eccc_xml_file_id column should be type integer');
select col_hasnt_default('swrs_transform', 'emission_factor', 'eccc_xml_file_id', 'emission_factor.eccc_xml_file_id column should not have a default value');

select col_type_is(      'swrs_transform', 'emission_factor', 'activity_name', 'character varying(1000)', 'emission_factor.activity_name column should be type varchar');
select col_is_null(      'swrs_transform', 'emission_factor', 'activity_name', 'emission_factor.activity_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'emission_factor', 'activity_name', 'emission_factor.activity_idx column should not have a default');

select col_type_is(      'swrs_transform', 'emission_factor', 'sub_activity_name', 'character varying(1000)', 'emission_factor.sub_activity_name column should be type varchar');
select col_is_null(      'swrs_transform', 'emission_factor', 'sub_activity_name', 'emission_factor.activity_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'emission_factor', 'sub_activity_name', 'emission_factor.activity_idx column should not have a default');

select col_type_is(      'swrs_transform', 'emission_factor', 'emission_factor_type', 'character varying(1000)', 'emission_factor.emission_factor_type column should be type varchar');
select col_is_null(      'swrs_transform', 'emission_factor', 'emission_factor_type', 'emission_factor.activity_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'emission_factor', 'emission_factor_type', 'emission_factor.activity_idx column should not have a default');

select col_type_is(      'swrs_transform', 'emission_factor', 'default_or_measured', 'character varying(1000)', 'emission_factor.default_or_measured column should be type varchar');
select col_is_null(      'swrs_transform', 'emission_factor', 'default_or_measured', 'emission_factor.activity_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'emission_factor', 'default_or_measured', 'emission_factor.activity_idx column should not have a default');

select col_type_is(      'swrs_transform', 'emission_factor', 'process_idx', 'integer', 'emission_factor.process_idx column should be type integer');
select col_is_null(      'swrs_transform', 'emission_factor', 'process_idx', 'emission_factor.process_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'emission_factor', 'process_idx', 'emission_factor.process_idx column should not  have a default');

select col_type_is(      'swrs_transform', 'emission_factor', 'sub_process_idx', 'integer', 'emission_factor.sub_process_idx column should be type integer');
select col_is_null(      'swrs_transform', 'emission_factor', 'sub_process_idx', 'emission_factor.sub_process_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'emission_factor', 'sub_process_idx', 'emission_factor.sub_process_idx column should not  have a default');

select col_type_is(      'swrs_transform', 'emission_factor', 'units_idx', 'integer', 'emission_factor.units_idx column should be type integer');
select col_is_null(      'swrs_transform', 'emission_factor', 'units_idx', 'emission_factor.units_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'emission_factor', 'units_idx', 'emission_factor.units_idx column should not  have a default');

select col_type_is(      'swrs_transform', 'emission_factor', 'unit_idx', 'integer', 'emission_factor.unit_idx column should be type integer');
select col_is_null(      'swrs_transform', 'emission_factor', 'unit_idx', 'emission_factor.unit_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'emission_factor', 'unit_idx', 'emission_factor.unit_idx column should not  have a default');

select col_type_is(      'swrs_transform', 'emission_factor', 'substances_idx', 'integer', 'emission_factor.substances_idx column should be type integer');
select col_is_null(      'swrs_transform', 'emission_factor', 'substances_idx', 'emission_factor.substances_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'emission_factor', 'substances_idx', 'emission_factor.substances_idx column should not  have a default');

select col_type_is(      'swrs_transform', 'emission_factor', 'substance_idx', 'integer', 'emission_factor.substance_idx column should be type integer');
select col_is_null(      'swrs_transform', 'emission_factor', 'substance_idx', 'emission_factor.substance_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'emission_factor', 'substance_idx', 'emission_factor.substance_idx column should not  have a default');

select col_type_is(      'swrs_transform', 'emission_factor', 'fuel_idx', 'integer', 'emission_factor.fuel_idx column should be type integer');
select col_is_null(      'swrs_transform', 'emission_factor', 'fuel_idx', 'emission_factor.fuel_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'emission_factor', 'fuel_idx', 'emission_factor.fuel_idx column should not  have a default');
truncate swrs_extract.eccc_xml_file;
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
                  <EmissionFactors EmissionFactorType="DefaultOrMeasuredEF">
                    <EmissionFactor>
                        <EmissionFactorGas>CO2</EmissionFactorGas>
                    </EmissionFactor>
                    <EmissionFactor>
                        <EmissionFactorGas>CH4</EmissionFactorGas>
                        <EmissionFactorAmount>0.966</EmissionFactorAmount>
                        <EmissionFactorUnitType>g/GJ</EmissionFactorUnitType>
                        <EmissionFactorDefaultOrMeasured>Measured</EmissionFactorDefaultOrMeasured>
                    </EmissionFactor>
                    <EmissionFactor>
                        <EmissionFactorGas>N2O</EmissionFactorGas>
                        <EmissionFactorAmount>0.861</EmissionFactorAmount>
                        <EmissionFactorUnitType>g/GJ</EmissionFactorUnitType>
                        <EmissionFactorDefaultOrMeasured>Default</EmissionFactorDefaultOrMeasured>
                    </EmissionFactor>
                </EmissionFactors>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
      </Process>
    </ActivityPages>
  </ActivityData>$$);

refresh materialized view swrs_transform.fuel with data;
refresh materialized view swrs_transform.emission_factor with data;


-- test foreign keys
-- emission_factor -> eccc_xml_filehave 
-- emission_factor -> fuel

select set_has(
    $$
    select fuel.eccc_xml_file_id from swrs_transform.emission_factor
    join swrs_transform.fuel
    on (
    emission_factor.eccc_xml_file_id =  fuel.eccc_xml_file_id
    and emission_factor.process_idx = fuel.process_idx
    and emission_factor.sub_process_idx = fuel.sub_process_idx
    and emission_factor.activity_name = fuel.activity_name
    and emission_factor.units_idx = fuel.units_idx
    and emission_factor.unit_idx = fuel.unit_idx)
    and emission_factor.fuel_idx = fuel.fuel_idx
    $$,

    'select eccc_xml_file_id from swrs_transform.fuel',

    'Foreign keys eccc_xml_file_id, process_idx, sub_process_idx, activity_name, units_idx, unit_idx and fuel.idx in ggircs_swrs_emission_factor reference swrs_transform.fuel'
);

-- test xml imports

select results_eq(
  $$ 
  select count(*) from swrs_transform.emission_factor 
  $$,
  $$
  values (2::bigint)
  $$,
  'emission_factor load function parsed the correct records (should skip records that do not have an EmissionFactorAmount tag)'
);

select results_eq(
  $$ 
  select emission_factor_type from swrs_transform.emission_factor 
  $$,
  $$ values
    ('DefaultOrMeasuredEF'::varchar),
    ('DefaultOrMeasuredEF'::varchar) 
  $$,
  'emission_factor parsed column emission_factor_type from xml'
);


select results_eq(
  $$ 
  select default_or_measured from swrs_transform.emission_factor 
  $$,
  $$ values
    ('Measured'::varchar),
    ('Default'::varchar) 
  $$,
  'emission_factor parsed column default_or_measured from xml'
);


select results_eq(
  $$ 
  select emission_factor_amount::numeric from swrs_transform.emission_factor 
  $$,
  $$ values
    ('0.966'::numeric),
    ('0.861'::numeric) 
  $$,
  'emission_factor parsed column emission_factor_amount from xml'
);


select results_eq(
  $$ 
  select emission_factor_gas from swrs_transform.emission_factor 
  $$,
  $$ values
    ('CH4'::varchar),
    ('N2O'::varchar) 
  $$,
  'emission_factor parsed column emission_factor_gas from xml'
);

select results_eq(
  $$ 
  select emission_factor_unit_type from swrs_transform.emission_factor 
  $$,
  $$ values
    ('g/GJ'::varchar),
    ('g/GJ'::varchar) 
  $$,
  'emission_factor parsed column emission_factor_unit_type from xml'
);


select * from finish();

rollback;
