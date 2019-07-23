set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(14);

-- Test matview report exists in schema swrs_transform
select has_materialized_view('swrs_transform', 'flat', 'swrs_transform.flat exists as a materialized view');

-- Test column names in matview report exist and are correct
select columns_are('swrs_transform'::name, 'flat'::name, array[
    'id'::name,
    'ghgr_import_id'::name,
    'element_id'::name,
    'swrs_report_id'::name,
    'class'::name,
    'attr'::name,
    'value'::name,
    --  'parent'::name,
    --  'grandparent'::name,
    'context'::name
]);

-- Test index names in matview report exist and are correct
select has_index('swrs_transform', 'flat', 'ggircs_flat_primary_key', 'swrs_transform.flat has index: ggircs_flat_primary_key');
select has_index('swrs_transform', 'flat', 'ggircs_flat_report', 'swrs_transform.flat has index: ggircs_flat_report');

-- Test unique indicies are defined unique
select index_is_unique('swrs_transform', 'flat', 'ggircs_flat_primary_key', 'swrs_transform.flat index ggircs_flat_primary_key is unique');

-- Test columns in matview report have correct types
select col_type_is('swrs_transform', 'flat', 'ghgr_import_id', 'integer', 'swrs_transform.flat.ghgr_import_id has type integer');
select col_type_is('swrs_transform', 'flat', 'element_id', 'bigint', 'swrs_transform.flat.element_id has type bigint');
select col_type_is('swrs_transform', 'flat', 'swrs_report_id', 'numeric(1000,0)', 'swrs_transform.flat.element_id has type bigint');
select col_type_is('swrs_transform', 'flat', 'class', 'character varying(10000)', 'swrs_transform.flat.class has type varchar');
select col_type_is('swrs_transform', 'flat', 'attr', 'character varying(10000)', 'swrs_transform.flat.attr has type varchar');
select col_type_is('swrs_transform', 'flat', 'value', 'character varying(10000)', 'swrs_transform.flat.value has type varchar');
select col_type_is('swrs_transform', 'flat', 'context', 'character varying(10000)', 'swrs_transform.flat.value has type varchar');

-- insert necessary data into table ghgr_import
insert into swrs_extract.ghgr_import (imported_at, xml_file) values ('2018-09-29T11:55:39.423', $$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ReportDetails>
    <ReportID>800855555</ReportID>
  </ReportDetails>
  <ActivityData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ActivityPages>
      <TotalCO2Captured>
        <TotalGroups TotalGroupType="TotalCO2CapturedEmissions">
          <Totals>
            <Emissions EmissionsGasType="CO2Captured">
              <TotalRow>
                <Groups>
                  <EmissionGroupTypes>BC_CO2Captured</EmissionGroupTypes>
                </Groups>
                <NotApplicable>true</NotApplicable>
                <CalculatedQuantity xsi:nil="true"/>
                <GasType>CO2nonbio</GasType>
              </TotalRow>
            </Emissions>
          </Totals>
        </TotalGroups>
      </TotalCO2Captured>
    </ActivityPages>
  </ActivityData>
</ReportData>
$$);

-- refresh necessary views with data
refresh materialized view swrs_transform.flat with data;

-- test the fk relation to ghgr_import
--  Test ghgr_import_id fk relation
select results_eq(
    $$
    select ghgr_import.id from swrs_transform.flat
    join swrs_extract.ghgr_import
    on
    flat.ghgr_import_id =  ghgr_import.id limit 1
    $$,

    'select id from swrs_extract.ghgr_import',

    'Foreign key ghgr_import_id in ggircs_swrs_flat reference swrs_extract.ghgr_import'
);

-- test the columnns for matview facility have been properly parsed from xml
select results_eq(
  'select element_id, swrs_report_id, class, attr, value, context from swrs_transform.flat order by element_id',

  $$
  with _flat as (
    select * from (
      values
        (1::bigint, 800855555::numeric, 'ReportID'::varchar, ''::varchar, '800855555'::varchar, '//'::varchar),
        (2::bigint, 800855555::numeric, 'TotalGroups'::varchar,'TotalGroupType'::varchar,'TotalCO2CapturedEmissions'::varchar, '//'::varchar),
        (3::bigint, 800855555::numeric, 'Emissions'::varchar,'EmissionsGasType'::varchar,'CO2Captured'::varchar, 'TotalCO2CapturedEmissions//'::varchar),
        (4::bigint, 800855555::numeric, 'EmissionGroupTypes'::varchar,''::varchar,'BC_CO2Captured'::varchar, 'TotalCO2CapturedEmissions/CO2Captured/'::varchar),
        (5::bigint, 800855555::numeric, 'NotApplicable'::varchar,''::varchar,'true'::varchar, 'TotalCO2CapturedEmissions/CO2Captured/'::varchar),
        (6::bigint, 800855555::numeric, 'GasType'::varchar,''::varchar,'CO2nonbio'::varchar, 'TotalCO2CapturedEmissions/CO2Captured/'::varchar)
    )
    as flat (element_id, swrs_report_id, class, attr, value, context)
  )
  select _flat.* from _flat;
  $$,

  'swrs_transform.flat() should return all xml nodes with values as rows');

select finish();
rollback;
