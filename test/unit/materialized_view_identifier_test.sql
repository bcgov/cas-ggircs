set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(21);

-- Test matview report exists in schema ggircs_swrs
select has_materialized_view('ggircs_swrs', 'identifier', 'Materialized view facility exists');

-- Test column names in matview identifier exist
select columns_are('ggircs_swrs'::name, 'identifier'::name,ARRAY[
    'ghgr_import_id'::name,
    'swrs_facility_id'::name,
    'path_context'::name,
    'identifier_idx'::name,
    'identifier_type'::name,
    'identifier_value'::name
]);

-- Test index names in matview report exist and are correct
select has_index('ggircs_swrs', 'identifier', 'ggircs_identifier_primary_key', 'ggircs_swrs.identifier has index: ggircs_identifier_primary_key');

-- Test unique indicies are defined unique
select index_is_unique('ggircs_swrs', 'identifier', 'ggircs_identifier_primary_key', 'Matview report index ggircs_identifier_primary_key is unique');

-- Test columns in matview report have correct types
select col_type_is('ggircs_swrs', 'identifier', 'ghgr_import_id', 'integer', 'ggircs_swrs.identifier column ghgr_import_id has type integer');
select col_type_is('ggircs_swrs', 'identifier', 'swrs_facility_id', 'numeric(1000,0)', 'ggircs_swrs.identifier column swrs_facility_id has type numeric');
select col_type_is('ggircs_swrs', 'identifier', 'path_context', 'character varying(1000)', 'ggircs_swrs.identifier column path_context has type varchar');
select col_type_is('ggircs_swrs', 'identifier', 'identifier_idx', 'integer', 'ggircs_swrs.identifier column identifier_idx has type integer');
select col_type_is('ggircs_swrs', 'identifier', 'identifier_type', 'character varying(1000)', 'ggircs_swrs.identifier column identifier_type has type varchar');
select col_type_is('ggircs_swrs', 'identifier', 'identifier_value', 'character varying(1000)', 'ggircs_swrs.identifier column identifier_value has type varchar');

-- insert necessary data into table ghgr_import
insert into ggircs_swrs.ghgr_import (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
    <Facility>
      <Identifiers>
        <IdentifierList>
          <Identifier>
            <IdentifierType>BCGHGID</IdentifierType>
            <IdentifierValue>R0B0T2</IdentifierValue>
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
$$);

-- refresh necessary views with data
refresh materialized view ggircs_swrs.facility with data;
refresh materialized view ggircs_swrs.identifier with data;

-- test the fk join on facility
select results_eq(
    'select facility.ghgr_import_id from ggircs_swrs.identifier ' ||
    'join ggircs_swrs.facility ' ||
    'on ' ||
    'identifier.ghgr_import_id =  facility.ghgr_import_id '||
    'and identifier_idx=0',

    'select ghgr_import_id from ggircs_swrs.facility',

    'Foreign keys ghgr_import_idin ggircs_swrs_identifier reference ggircs_swrs.facility'
);


-- test the columnns for ggircs_swrs.identifier have been properly parsed from xml
select results_eq(
  'select ghgr_import_id from ggircs_swrs.identifier where identifier_idx=0',
  'select id from ggircs_swrs.ghgr_import',
  'ggircs_swrs.identifier parsed column ghgr_import_id'
);

select results_eq(
  'select swrs_facility_id from ggircs_swrs.identifier where identifier_idx=0',
  ARRAY[666::numeric],
  'ggircs_swrs.identifier parsed column swrs_facility_id'
);

select results_eq(
  'select path_context from ggircs_swrs.identifier where identifier_idx=0',
  ARRAY['RegistrationData'::varchar],
  'ggircs_swrs.identifier parsed column path_context'
);

select results_eq(
  'select identifier_idx from ggircs_swrs.identifier where identifier_idx=0',
  ARRAY[0::integer],
  'ggircs_swrs.identifier parsed column identifier_idx'
);

-- Test that if the identifier type = 'BCGHGID' that the value is grabbed from ProgramID in OperationalWorkerReport

select results_eq(
  'select identifier_type from ggircs_swrs.identifier where identifier_idx=0',
  ARRAY['BCGHGID'::varchar],
  'ggircs_swrs.identifier parsed column identifier_type'
);
select results_eq(
  'select identifier_value from ggircs_swrs.identifier where identifier_idx=0',
  ARRAY['1234'::varchar],
  'ggircs_swrs.identifier parsed column identifier_value'
);

-- Test that the identifier value is not affected if identifier_type is not 'BCGHGID'
select results_eq(
  'select identifier_type from ggircs_swrs.identifier where identifier_idx=1',
  ARRAY['GHGRP Identification Number'::varchar],
  'ggircs_swrs.identifier parsed column identifier_type'
);
select results_eq(
  'select identifier_value from ggircs_swrs.identifier where identifier_idx=1',
  ARRAY['R0B0T2'::varchar],
  'ggircs_swrs.identifier parsed column identifier_value'
);

delete from ggircs_swrs.ghgr_import where id < 20;
insert into ggircs_swrs.ghgr_import (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
    <Facility>
      <Identifiers>
        <IdentifierList>
          <Identifier>
            <IdentifierType>BCGHGID</IdentifierType>
            <IdentifierValue>R0B0T2</IdentifierValue>
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

refresh materialized view ggircs_swrs.identifier;

-- Test that when OperationalWorkerReport/ProgramID does not exist, the value for BCGHGID is taken from <IdentifierValue>
select results_eq(
  'select identifier_type from ggircs_swrs.identifier where identifier_idx=0',
  ARRAY['BCGHGID'::varchar],
  'ggircs_swrs.identifier parsed column identifier_type'
);
select results_eq(
  'select identifier_value from ggircs_swrs.identifier',
  ARRAY['R0B0T2'::varchar],
  'ggircs_swrs.identifier parsed column identifier_value'
);

select finish();
rollback;
