set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(17);

-- Test matview report exists in schema swrs_transform
select has_materialized_view('swrs_transform', 'identifier', 'Materialized view facility exists');

-- Test column names in matview identifier exist
select columns_are('swrs_transform'::name, 'identifier'::name,ARRAY[
    'id'::name,
    'eccc_xml_file_id'::name,
    'swrs_facility_id'::name,
    'path_context'::name,
    'identifier_idx'::name,
    'identifier_type'::name,
    'identifier_value'::name
]);

-- Test index names in matview report exist and are correct
select has_index('swrs_transform', 'identifier', 'ggircs_identifier_primary_key', 'swrs_transform.identifier has index: ggircs_identifier_primary_key');

-- Test unique indicies are defined unique
select index_is_unique('swrs_transform', 'identifier', 'ggircs_identifier_primary_key', 'Matview report index ggircs_identifier_primary_key is unique');

-- Test columns in matview report have correct types
select col_type_is('swrs_transform', 'identifier', 'eccc_xml_file_id', 'integer', 'swrs_transform.identifier column eccc_xml_file_id has type integer');
select col_type_is('swrs_transform', 'identifier', 'swrs_facility_id', 'integer', 'swrs_transform.identifier column swrs_facility_id has type numeric');
select col_type_is('swrs_transform', 'identifier', 'path_context', 'character varying(1000)', 'swrs_transform.identifier column path_context has type varchar');
select col_type_is('swrs_transform', 'identifier', 'identifier_idx', 'integer', 'swrs_transform.identifier column identifier_idx has type integer');
select col_type_is('swrs_transform', 'identifier', 'identifier_type', 'character varying(1000)', 'swrs_transform.identifier column identifier_type has type varchar');
select col_type_is('swrs_transform', 'identifier', 'identifier_value', 'character varying(1000)', 'swrs_transform.identifier column identifier_value has type varchar');

-- insert necessary data into table eccc_xml_file
insert into swrs_extract.eccc_xml_file (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
    <Facility>
      <Identifiers>
        <IdentifierList>
          <Identifier>
            <IdentifierType>BCGHGID</IdentifierType>
            <IdentifierValue>R0B0T1</IdentifierValue>
          </Identifier>
          <Identifier>
            <IdentifierType>GHGRP Identification Number</IdentifierType>
            <IdentifierValue>R0B0T2</IdentifierValue>
          </Identifier>
        </IdentifierList>
      </Identifiers>
    </Facility>
  </RegistrationData>
  <ReportDetails>
    <FacilityId>666</FacilityId>
  </ReportDetails>
  <OperationalWorkerReport>
    <ProgramID>1234</ProgramID>
  </OperationalWorkerReport>
</ReportData>
$$), ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
    <Facility>
      <Identifiers>
        <IdentifierList>
          <Identifier>
            <IdentifierType>BCGHGID</IdentifierType>
            <IdentifierValue>R0B0T3</IdentifierValue>
          </Identifier>
        </IdentifierList>
      </Identifiers>
    </Facility>
  </RegistrationData>
  <ReportDetails>
    <FacilityId>666</FacilityId>
  </ReportDetails>
</ReportData>
$$);

-- refresh necessary views with data
refresh materialized view swrs_transform.identifier with data;

-- test the columnns for swrs_transform.identifier have been properly parsed from xml
select results_eq(
  'select distinct(eccc_xml_file_id) from swrs_transform.identifier order by eccc_xml_file_id',
  'select id from swrs_extract.eccc_xml_file order by id',
  'swrs_transform.identifier references column eccc_xml_file_id'
);

select results_eq(
  'select swrs_facility_id from swrs_transform.identifier',
  ARRAY[666::integer, 666::integer, 666::integer],
  'swrs_transform.identifier parsed column swrs_facility_id'
);

select results_eq(
  'select path_context from swrs_transform.identifier',
  ARRAY['RegistrationData'::varchar, 'RegistrationData'::varchar, 'RegistrationData'::varchar],
  'swrs_transform.identifier parsed column path_context'
);

select results_eq(
  'select identifier_idx from swrs_transform.identifier',
  ARRAY[0::integer, 1::integer, 0::integer],
  'swrs_transform.identifier parsed column identifier_idx'
);

select results_eq(
  'select identifier_type from swrs_transform.identifier',
  ARRAY['BCGHGID'::varchar, 'GHGRP Identification Number'::varchar, 'BCGHGID'::varchar],
  'swrs_transform.identifier parsed column identifier_type'
);

-- The identifier value should be overridden if identifier_type is 'BCGHGID' and ProgramID is not null (1234)
-- The identifier value should not be overridden if identifier_type is not 'BCGHGID' (R0B0T2)
-- The identifier value should not be overridden if identifier_type is 'BCGHGID' and ProgramID is null (R0B0T3)
select results_eq(
  'select identifier_value from swrs_transform.identifier',
  ARRAY['1234'::varchar, 'R0B0T2'::varchar, 'R0B0T3'::varchar],
  'swrs_transform.identifier parsed column identifier_value'
);

-- refresh necessary views with data
refresh materialized view swrs_transform.facility with data;

-- test the fk join on facility
select results_eq(
  $$
    select facility.eccc_xml_file_id from swrs_transform.identifier
    join swrs_transform.facility
    on identifier.eccc_xml_file_id = facility.eccc_xml_file_id
    and identifier_idx=0
    order by facility.eccc_xml_file_id
  $$,
  'select eccc_xml_file_id from swrs_transform.facility order by eccc_xml_file_id',
  'Foreign keys eccc_xml_file_idin ggircs_swrs_identifier reference swrs_transform.facility'
);

select finish();
rollback;
