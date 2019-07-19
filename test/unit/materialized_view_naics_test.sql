set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(19);

-- Test matview report exists in schema ggircs_swrs
select has_materialized_view('ggircs_swrs', 'naics', 'ggircs_swrs_transform.naics exists');
--
-- -- Test column names in matview report exist

select columns_are('ggircs_swrs'::name, 'naics'::name, ARRAY[
    'id'::name,
    'ghgr_import_id'::name,
    'swrs_facility_id'::name,
    'path_context'::name,
    'naics_code_idx'::name,
    'naics_classification'::name,
    'naics_code'::name,
    'naics_priority'::name
]);

-- -- Test index names in matview report exist and are correct
select has_index('ggircs_swrs', 'naics', 'ggircs_naics_primary_key', 'ggircs_swrs_transform.naics has index: ggircs_naics_primary_key');

-- -- Test unique indicies are defined unique
select index_is_unique('ggircs_swrs', 'naics', 'ggircs_naics_primary_key', 'ggircs_swrs_transform.naics index ggircs_facility_primary_key is unique');

-- -- Test columns in matview report have correct types
select col_type_is('ggircs_swrs', 'naics', 'ghgr_import_id', 'integer', 'ggircs_swrs_transform.naics.facility_id has type integer');
select col_type_is('ggircs_swrs', 'naics', 'swrs_facility_id', 'integer', 'ggircs_swrs_transform.naics.swrs_facility_id has type numeric');
select col_type_is('ggircs_swrs', 'naics', 'path_context', 'character varying(1000)', 'ggircs_swrs_transform.naics.path_context has type varchar');
select col_type_is('ggircs_swrs', 'naics', 'naics_code_idx', 'integer', 'ggircs_swrs_transform.naics.naics_code_idx has type integer');
select col_type_is('ggircs_swrs', 'naics', 'naics_classification', 'character varying(1000)', 'ggircs_swrs_transform.naics.naics_classification has type varchar');
select col_type_is('ggircs_swrs', 'naics', 'naics_code', 'integer', 'ggircs_swrs_transform.naics.naics_code has type integer');
select col_type_is('ggircs_swrs', 'naics', 'naics_priority', 'character varying(1000)', 'ggircs_swrs_transform.naics.naics_priority has type varchar');

-- insert necessary data into table ghgr_import
insert into ggircs_swrs_extract.ghgr_import (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
    <Facility>
     <Identifiers>
       <NAICSCodeList>
          <NAICSCode>
            <NAICSClassification>Conventional Oil and Gas Extraction</NAICSClassification>
            <Code>123456</Code>
            <NaicsPriority>Primary</NaicsPriority>
          </NAICSCode>
        </NAICSCodeList>
      </Identifiers>
    </Facility>
  </RegistrationData>
  <ReportDetails>
    <FacilityId>666</FacilityId>
  </ReportDetails>
</ReportData>
$$);

-- refresh necessary views with data
refresh materialized view ggircs_swrs_transform.facility with data;
refresh materialized view ggircs_swrs_transform.naics with data;

--  Test the foreign key join on facility
select results_eq(
    $$
    select facility.ghgr_import_id from ggircs_swrs_transform.naics
    join ggircs_swrs_transform.facility
    on
    naics.ghgr_import_id = facility.ghgr_import_id
    $$,

    'select ghgr_import_id from ggircs_swrs_transform.facility',

    'Foreign keys ghgr_import_id, swrs_facility_id in ggircs_swrs_naics reference ggircs_swrs_transform.facility'
);

-- test that the columns in ggircs_swrs_transform.naics have been properly parsed from xml
select results_eq(
  'select ghgr_import_id from ggircs_swrs_transform.naics',
  'select id from ggircs_swrs_extract.ghgr_import',
  'ggircs_swrs_transform.naics parsed column ghgr_import_id'
);

select results_eq(
  'select swrs_facility_id from ggircs_swrs_transform.naics',
  ARRAY[666::integer],
  'ggircs_swrs_transform.naics parsed column swrs_facility_id'
);

select results_eq(
  'select path_context from ggircs_swrs_transform.naics',
  ARRAY['RegistrationData'::varchar],
  'ggircs_swrs_transform.naics parsed column path_context'
);

select results_eq(
  'select naics_code_idx from ggircs_swrs_transform.naics',
  ARRAY[0::integer],
  'ggircs_swrs_transform.naics parsed column naics_code_idx'
);

select results_eq(
  'select naics_classification from ggircs_swrs_transform.naics',
  ARRAY['Conventional Oil and Gas Extraction'::varchar],
  'ggircs_swrs_transform.naics parsed column naics_classification'
);
select results_eq(
  'select naics_code from ggircs_swrs_transform.naics',
  ARRAY[123456::integer],
  'ggircs_swrs_transform.naics parsed column naics_code'
);
select results_eq(
  'select naics_priority from ggircs_swrs_transform.naics',
  ARRAY['Primary'::varchar],
  'ggircs_swrs_transform.naics parsed column naics_priority'
);

select finish();
rollback;
