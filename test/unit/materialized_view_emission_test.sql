set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(40);

select has_materialized_view(
    'ggircs_swrs', 'emission',
    'ggircs_swrs.emission should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'emission', 'ggircs_emission_primary_key',
    'ggircs_swrs.emission should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'emission'::name, array[
    'ghgr_import_id'::name,
    'process_idx'::name,
    'sub_process_idx'::name,
    'unit_idx'::name,
    'fuel_idx'::name,
    'idx'::name,
    'emission_type'::name,
    'gas_type'::name,
    'methodology'::name,
    'not_applicable'::name,
    'quantity'::name,
    'calculated_quantity'::name,
    'emission_category'::name

]);


select col_type_is(      'ggircs_swrs', 'emission', 'ghgr_import_id', 'integer', 'emission.ghgr_import_id column should be type integer');
select col_hasnt_default('ggircs_swrs', 'emission', 'ghgr_import_id', 'emission.ghgr_import_id column should not have a default value');

--  select col_is_null(      'ggircs_swrs', 'emission', 'process_idx', 'emission.process_idx column should allow null');
select col_type_is(      'ggircs_swrs', 'emission', 'process_idx', 'integer', 'emission.process_idx column should be type integer');
select col_hasnt_default('ggircs_swrs', 'emission', 'process_idx', 'emission.process_idx column should not have a default');

--  select col_is_null(      'ggircs_swrs', 'emission', 'sub_process_idx', 'emission.sub_process_idx column should allow null');
select col_type_is(      'ggircs_swrs', 'emission', 'sub_process_idx', 'integer', 'emission.sub_process_idx column should be type integer');
select col_hasnt_default('ggircs_swrs', 'emission', 'sub_process_idx', 'emission.sub_process_idx column should not have a default');

--  select col_is_null(      'ggircs_swrs', 'emission', 'unit_idx', 'emission.unit_idx column should allow null');
select col_type_is(      'ggircs_swrs', 'emission', 'unit_idx', 'integer', 'emission.unit_idx column should be type integer');
select col_hasnt_default('ggircs_swrs', 'emission', 'unit_idx', 'emission.unit_idx column should not have a default');

-- select col_is_null(      'ggircs_swrs', 'emission', 'fuel_idx', 'emission.fuel_idx column should allow null');
select col_type_is(      'ggircs_swrs', 'emission', 'fuel_idx', 'integer', 'emission.fuel_idx column should be type integer');
select col_hasnt_default('ggircs_swrs', 'emission', 'fuel_idx', 'emission.fuel_idx column should not have a default');

--  select col_is_null(      'ggircs_swrs', 'emission', 'idx', 'emission.idx column should allow null');
select col_type_is(      'ggircs_swrs', 'emission', 'idx', 'integer', 'emission.idx column should be type integer');
select col_hasnt_default('ggircs_swrs', 'emission', 'idx', 'emission.idx column should not have a default');

select col_type_is(      'ggircs_swrs', 'emission', 'gas_type', 'character varying(1000)', 'emission.gas_type column should be type text');
select col_hasnt_default('ggircs_swrs', 'emission', 'gas_type', 'emission.gas_type column should not have a default');

select col_type_is(      'ggircs_swrs', 'emission', 'emission_type', 'character varying(1000)', 'emission.emission_type column should be type text');
select col_hasnt_default('ggircs_swrs', 'emission', 'emission_type', 'emission.emission_type column should not have a default');

select col_type_is(      'ggircs_swrs', 'emission', 'methodology', 'character varying(1000)', 'emission.methodology column should be type text');
select col_hasnt_default('ggircs_swrs', 'emission', 'methodology', 'emission.methodology column should not have a default');

select col_type_is(      'ggircs_swrs', 'emission', 'not_applicable', 'boolean', 'emission.not_applicable column should be type boolean');
select col_hasnt_default('ggircs_swrs', 'emission', 'not_applicable', 'emission.not_applicable column should not have a default');

select col_type_is(      'ggircs_swrs', 'emission', 'emission_category', 'character varying(1000)', 'emission.emission_category column should be type text');
select col_hasnt_default('ggircs_swrs', 'emission', 'emission_category', 'emission.emission_category column should not have a default');

select col_type_is(      'ggircs_swrs', 'emission', 'quantity', 'numeric(1000,0)', 'emission.quantity column should be type numeric');
-- select col_has_default(  'ggircs_swrs', 'emission', 'quantity', 'emission.quantity column should have a default');

select col_type_is(      'ggircs_swrs', 'emission', 'calculated_quantity', 'numeric(1000,0)', 'emission.calculated_quantity column should be type numeric');
-- select col_has_default(  'ggircs_swrs', 'emission', 'calculated_quantity', 'emission.calculated_quantity column should have a default');

-- Insert data for fixture based testing
insert into ggircs_swrs.ghgr_import (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ActivityData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ActivityPages>
      <Process ProcessName="GeneralStationaryCombustion">
        <SubProcess SubprocessName="(a) general stationary combustion, useful energy" InformationRequirement="Required">
          <Units>
            <Unit>
              <Fuels>
                <Fuel>
                  <Emissions EmissionsType="Combustion: Field gas or Process Vent Gas">
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>28215</Quantity>
                      <CalculatedQuantity>28215</CalculatedQuantity>
                      <GasType>CO2nonbio</GasType>
                      <Methodology>Methodology 2 (measured HHV/Steam)</Methodology>
                    </Emission>
                  </Emissions>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
      </Process>
    </ActivityPages>
  </ActivityData>
</ReportData>

$$);


-- refresh necessary views with data
refresh materialized view ggircs_swrs.emission with data;

-- test the columns for matview facility have been properly parsed from xml
select results_eq(
  'select ghgr_import_id from ggircs_swrs.emission',
  'select id from ggircs_swrs.ghgr_import',
  'ggircs_swrs.emission.ghgr_import_id relates to ggircs_swrs.ghgr_import.id'
);

-- Extract process_idx
select results_eq(
  'select process_idx from ggircs_swrs.emission',
   ARRAY[0::integer],
  'ggircs_swrs.emission.process_idx is extracted'
);

-- Extract sub_process_idx
select results_eq(
  'select sub_process_idx from ggircs_swrs.emission',
   ARRAY[0::integer],
  'ggircs_swrs.emission.sub_process_idx is extracted'
);

-- Extract unit_idx
select results_eq(
  'select unit_idx from ggircs_swrs.emission',
   ARRAY[0::integer],
  'ggircs_swrs.emission.unit_idx is extracted'
);

-- Extract fuel_idx
select results_eq(
  'select fuel_idx from ggircs_swrs.emission',
   ARRAY[0::integer],
  'ggircs_swrs.emission.fuel_idx is extracted'
);

-- Extract idx
select results_eq(
  'select idx from ggircs_swrs.emission',
   ARRAY[0::integer],
  'ggircs_swrs.emission.idx is extracted'
);

-- Extract emission_type
select results_eq(
  'select emission_type from ggircs_swrs.emission',
   ARRAY['Combustion: Field gas or Process Vent Gas'::varchar(1000)],
  'ggircs_swrs.emission.emission_type is extracted'
);

-- Extract gas_type
select results_eq(
  'select gas_type from ggircs_swrs.emission',
   ARRAY['CO2nonbio'::varchar(1000)],
  'ggircs_swrs.emission.gas_type is extracted'
);

-- Extract methodology
select results_eq(
  'select methodology from ggircs_swrs.emission',
   ARRAY['Methodology 2 (measured HHV/Steam)'::varchar(1000)],
  'ggircs_swrs.emission.methodology is extracted'
);

-- Extract not_applicable
  select results_eq(
  'select not_applicable from ggircs_swrs.emission',
   ARRAY['false'::bool],
  'ggircs_swrs.emission.not_applicable is extracted'
);

-- Extract quantity
  select results_eq(
  'select quantity from ggircs_swrs.emission',
   ARRAY[28215::numeric(1000,0)],
  'ggircs_swrs.emission.quantity is extracted'
);

-- Extract calculated_quantity
  select results_eq(
  'select calculated_quantity from ggircs_swrs.emission',
   ARRAY[28215::numeric(1000,0)],
  'ggircs_swrs.emission.calculated_quantity is extracted'
);

-- Extract emission_category
select results_eq(
  'select emission_category from ggircs_swrs.emission',
   ARRAY['BC_ScheduleB_GeneralStationaryCombustionEmissions'::varchar(1000)],
  'ggircs_swrs.emission.emission_category is extracted'
);


select * from finish();
rollback;
