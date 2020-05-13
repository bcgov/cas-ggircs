set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(19);

-- Test matview report exists in schema swrs_transform
select has_materialized_view('swrs_transform', 'naics', 'swrs_transform.naics exists');
--
-- -- Test column names in matview report exist

select columns_are('swrs_transform'::name, 'naics'::name, ARRAY[
    'id'::name,
    'eccc_xml_file_id'::name,
    'swrs_facility_id'::name,
    'path_context'::name,
    'naics_code_idx'::name,
    'naics_classification'::name,
    'naics_code'::name,
    'naics_priority'::name
]);

-- -- Test index names in matview report exist and are correct
select has_index('swrs_transform', 'naics', 'ggircs_naics_primary_key', 'swrs_transform.naics has index: ggircs_naics_primary_key');

-- -- Test unique indicies are defined unique
select index_is_unique('swrs_transform', 'naics', 'ggircs_naics_primary_key', 'swrs_transform.naics index ggircs_facility_primary_key is unique');

-- -- Test columns in matview report have correct types
select col_type_is('swrs_transform', 'naics', 'eccc_xml_file_id', 'integer', 'swrs_transform.naics.facility_id has type integer');
select col_type_is('swrs_transform', 'naics', 'swrs_facility_id', 'integer', 'swrs_transform.naics.swrs_facility_id has type numeric');
select col_type_is('swrs_transform', 'naics', 'path_context', 'character varying(1000)', 'swrs_transform.naics.path_context has type varchar');
select col_type_is('swrs_transform', 'naics', 'naics_code_idx', 'integer', 'swrs_transform.naics.naics_code_idx has type integer');
select col_type_is('swrs_transform', 'naics', 'naics_classification', 'character varying(1000)', 'swrs_transform.naics.naics_classification has type varchar');
select col_type_is('swrs_transform', 'naics', 'naics_code', 'integer', 'swrs_transform.naics.naics_code has type integer');
select col_type_is('swrs_transform', 'naics', 'naics_priority', 'character varying(1000)', 'swrs_transform.naics.naics_priority has type varchar');

-- insert necessary data into table eccc_xml_file
insert into swrs_extract.eccc_xml_file (xml_file) values ($$
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
refresh materialized view swrs_transform.facility with data;
refresh materialized view swrs_transform.naics with data;

--  Test the foreign key join on facility
select results_eq(
    $$
    select facility.eccc_xml_file_id from swrs_transform.naics
    join swrs_transform.facility
    on
    naics.eccc_xml_file_id = facility.eccc_xml_file_id
    $$,

    'select eccc_xml_file_id from swrs_transform.facility',

    'Foreign keys eccc_xml_file_id, swrs_facility_id in ggircs_swrs_naics reference swrs_transform.facility'
);

-- test that the columns in swrs_transform.naics have been properly parsed from xml
select results_eq(
  'select eccc_xml_file_id from swrs_transform.naics',
  'select id from swrs_extract.eccc_xml_file',
  'swrs_transform.naics parsed column eccc_xml_file_id'
);

select results_eq(
  'select swrs_facility_id from swrs_transform.naics',
  ARRAY[666::integer],
  'swrs_transform.naics parsed column swrs_facility_id'
);

select results_eq(
  'select path_context from swrs_transform.naics',
  ARRAY['RegistrationData'::varchar],
  'swrs_transform.naics parsed column path_context'
);

select results_eq(
  'select naics_code_idx from swrs_transform.naics',
  ARRAY[0::integer],
  'swrs_transform.naics parsed column naics_code_idx'
);

select results_eq(
  'select naics_classification from swrs_transform.naics',
  ARRAY['Conventional Oil and Gas Extraction'::varchar],
  'swrs_transform.naics parsed column naics_classification'
);
select results_eq(
  'select naics_code from swrs_transform.naics',
  ARRAY[123456::integer],
  'swrs_transform.naics parsed column naics_code'
);
select results_eq(
  'select naics_priority from swrs_transform.naics',
  ARRAY['Primary'::varchar],
  'swrs_transform.naics parsed column naics_priority'
);

select finish();
rollback;
