set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(27);

select has_materialized_view(
    'swrs_transform', 'permit',
    'swrs_transform.permit should be a materialized view'
);

select has_index(
    'swrs_transform', 'permit', 'ggircs_permit_primary_key',
    'swrs_transform.permit should have a primary key'
);

select columns_are('swrs_transform'::name, 'permit'::name, array[
    'id'::name,
    'eccc_xml_file_id'::name,
    'path_context'::name,
    'permit_idx'::name,
    'issuing_agency'::name,
    'issuing_dept_agency_program'::name,
    'permit_number'::name
]);

select col_type_is(      'swrs_transform', 'permit', 'eccc_xml_file_id', 'integer', 'permit.eccc_xml_file_id column should be type integer');
select col_hasnt_default('swrs_transform', 'permit', 'eccc_xml_file_id', 'permit.eccc_xml_file_id column should not have a default value');

--  select has_column(       'swrs_transform', 'permit', 'path_context', 'permit.path_context column should exist');
select col_type_is(      'swrs_transform', 'permit', 'path_context', 'character varying(1000)', 'permit.path_context column should be type varchar');
select col_is_null(      'swrs_transform', 'permit', 'path_context', 'permit.path_context column should not allow null');
select col_hasnt_default('swrs_transform', 'permit', 'path_context', 'permit.path_context column should not have a default');

--  select has_column(       'swrs_transform', 'permit', 'permit_idx', 'permit.permit_idx column should exist');
select col_type_is(      'swrs_transform', 'permit', 'permit_idx', 'integer', 'permit.permit_idx column should be type integer');
select col_is_null(      'swrs_transform', 'permit', 'permit_idx', 'permit.permit_idx column should not allow null');
select col_hasnt_default('swrs_transform', 'permit', 'permit_idx', 'permit.permit_idx column should not have a default');

--  select has_column(       'swrs_transform', 'permit', 'issuing_agency', 'permit.issuing_agency column should exist');
select col_type_is(      'swrs_transform', 'permit', 'issuing_agency', 'character varying(1000)', 'permit.issuing_agency column should be type varchar');
select col_is_null(      'swrs_transform', 'permit', 'issuing_agency', 'permit.issuing_agency column should not allow null');
select col_hasnt_default('swrs_transform', 'permit', 'issuing_agency', 'permit.issuing_agency column should not have a default');

--  select has_column(       'swrs_transform', 'permit', 'issuing_dept_agency_program', 'permit.issuing_dept_agency_program column should exist');
select col_type_is(      'swrs_transform', 'permit', 'issuing_dept_agency_program', 'character varying(1000)', 'permit.issuing_dept_agency_program column should be type varchar');
select col_is_null(      'swrs_transform', 'permit', 'issuing_dept_agency_program', 'permit.issuing_dept_agency_program column should not allow null');
select col_hasnt_default('swrs_transform', 'permit', 'issuing_dept_agency_program', 'permit.issuing_dept_agency_program column should not have a default');

--  select has_column(       'swrs_transform', 'permit', 'permit_number', 'permit.permit_number column should exist');
select col_type_is(      'swrs_transform', 'permit', 'permit_number', 'character varying(1000)', 'permit.permit_number column should be type varchar');
select col_is_null(      'swrs_transform', 'permit', 'permit_number', 'permit.permit_number column should not allow null');
select col_hasnt_default('swrs_transform', 'permit', 'permit_number', 'permit.permit_number column should not have a default');


insert into swrs_extract.eccc_xml_file (xml_file) values ($$<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
    <Facility>
      <Identifiers>
        <Permits>
          <Permit>
            <IssuingAgency>BC Ministry of Environment</IssuingAgency>
            <IssuingDeptAgencyProgram>abc</IssuingDeptAgencyProgram>
            <PermitNumber>AB-12345</PermitNumber>
          </Permit>
        </Permits>
      </Identifiers>
    </Facility>
  </RegistrationData>
  <ReportDetails>
    <FacilityId>666</FacilityId>
  </ReportDetails>
</ReportData>
$$);


refresh materialized view swrs_transform.facility with data;
refresh materialized view swrs_transform.permit with data;

select results_eq(
     $$
     select facility.swrs_facility_id from swrs_transform.permit
     join swrs_transform.facility
     on
     permit.eccc_xml_file_id = facility.eccc_xml_file_id
     $$,

    'select swrs_facility_id from swrs_transform.facility',

    'Foreign key eccc_xml_file_id in ggircs_swrs_parent_facility references swrs_transform.facility'
);

-- XML import tests
select results_eq(
    'select eccc_xml_file_id from swrs_transform.permit',
    'select id from swrs_extract.eccc_xml_file',
    'column eccc_xml_file_id in permit correctly parsed xml'
);

select results_eq(
    'select path_context from swrs_transform.permit',
    ARRAY['RegistrationData'::varchar],
    'column path_context in permit correctly parsed xml'
);

select results_eq(
    'select permit_idx from swrs_transform.permit',
    ARRAY[0::integer],
    'column permit_idx in permit correctly parsed xml'
);

select results_eq(
    'select issuing_agency from swrs_transform.permit',
    ARRAY['BC Ministry of Environment'::varchar],
    'column issuing_agency in permit correctly parsed xml'
);

select results_eq(
    'select issuing_dept_agency_program from swrs_transform.permit',
    ARRAY['abc'::varchar],
    'column issuing_dept_agency_program in permit correctly parsed xml'
);

select results_eq(
    'select permit_number from swrs_transform.permit',
    ARRAY['AB-12345'::varchar],
    'column permit_number in permit correctly parsed xml'
);

select * from finish();
rollback;
