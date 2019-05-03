set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(22);

-- Test matview report exists in schema ggircs_swrs
select has_materialized_view('ggircs_swrs', 'identifier', 'Materialized view facility exists');

-- Test column names in matview report exist and are correct
select has_column('ggircs_swrs', 'identifier', 'id', 'ggircs_swrs.identifier has column: id');
select has_column('ggircs_swrs', 'identifier', 'ghgr_import_id', 'ggircs_swrs.identifier has column: ghgr_import_id');
select has_column('ggircs_swrs', 'identifier', 'swrs_facility_id', 'ggircs_swrs.identifier has column: swrs_facility_id');
select has_column('ggircs_swrs', 'identifier', 'identifier_type', 'ggircs_swrs.identifier has column: identifier_type');
select has_column('ggircs_swrs', 'identifier', 'identifier_value', 'ggircs_swrs.identifier has column: identifier_value');
select has_column('ggircs_swrs', 'identifier', 'swrs_identifier_history_id', 'ggircs_swrs.identifier has column: swrs_identifier_history_id');

-- Test index names in matview report exist and are correct
select has_index('ggircs_swrs', 'identifier', 'ggircs_identifier_primary_key', 'ggircs_swrs.identifier has index: ggircs_identifier_primary_key');
select has_index('ggircs_swrs', 'identifier', 'ggircs_swrs_identifier_history', 'ggircs_swrs.identifier has index: ggircs_swrs_identifier_history');

-- Test unique indicies are defined unique
select index_is_unique('ggircs_swrs', 'facility', 'ggircs_facility_primary_key', 'Matview report index ggircs_facility_primary_key is unique');

-- Test columns in matview report have correct types
select col_type_is('ggircs_swrs', 'identifier', 'id', 'bigint', 'ggircs_swrs.identifier column id has type bigint');
select col_type_is('ggircs_swrs', 'identifier', 'ghgr_import_id', 'integer', 'ggircs_swrs.identifier column ghgr_import_id has type integer');
select col_type_is('ggircs_swrs', 'identifier', 'swrs_facility_id', 'numeric(1000,0)', 'ggircs_swrs.identifier column swrs_facility_id has type numeric');
select col_type_is('ggircs_swrs', 'identifier', 'identifier_type', 'character varying(1000)', 'ggircs_swrs.identifier column identifier_type has type varchar');
select col_type_is('ggircs_swrs', 'identifier', 'identifier_value', 'character varying(1000)', 'ggircs_swrs.identifier column identifier_value has type varchar');
select col_type_is('ggircs_swrs', 'identifier', 'swrs_identifier_history_id', 'bigint', 'ggircs_swrs.identifier column swrs_identifier_history_id has type bigint');


-- insert necessary data into table ghgr_import
insert into ggircs_swrs.ghgr_import (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
    <Facility>
      <Identifiers>
        <IdentifierList>
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
</ReportData>
$$);

-- refresh necessary views with data
refresh materialized view ggircs_swrs.identifier with data;

-- test the columnns for ggircs_swrs.identifier have been properly parsed from xml
select results_eq(
  'select id from ggircs_swrs.identifier',
  ARRAY[1::bigint],
  'ggircs_swrs.identifier parsed column id'
);
select results_eq(
  'select ghgr_import_id from ggircs_swrs.identifier',
  'select id from ggircs_swrs.ghgr_import',
  'ggircs_swrs.identifier parsed column ghgr_import_id'
);
select results_eq(
  'select swrs_facility_id from ggircs_swrs.identifier',
  ARRAY[666::numeric],
  'ggircs_swrs.identifier parsed column swrs_facility_id'
);
select results_eq(
  'select identifier_type from ggircs_swrs.identifier',
  ARRAY['GHGRP Identification Number'::varchar],
  'ggircs_swrs.identifier parsed column identifier_type'
);
select results_eq(
  'select identifier_value from ggircs_swrs.identifier',
  ARRAY['R0B0T2'::varchar],
  'ggircs_swrs.identifier parsed column identifier_value'
);
select results_eq(
  'select swrs_identifier_history_id from ggircs_swrs.identifier',
  ARRAY[1::bigint],
  'ggircs_swrs.identifier parsed column swrs_identifier_history_id'
);

select finish();
rollback;
