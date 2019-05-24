set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(27);

select has_materialized_view(
    'ggircs_swrs', 'permit',
    'ggircs_swrs.permit should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'permit', 'ggircs_permit_primary_key',
    'ggircs_swrs.permit should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'permit'::name, array[
    'ghgr_import_id'::name,
    'path_context'::name,
    'permit_idx'::name,
    'issuing_agency'::name,
    'issuing_dept_agency_program'::name,
    'permit_number'::name
]);

select col_type_is(      'ggircs_swrs', 'permit', 'ghgr_import_id', 'integer', 'permit.ghgr_import_id column should be type integer');
select col_hasnt_default('ggircs_swrs', 'permit', 'ghgr_import_id', 'permit.ghgr_import_id column should not have a default value');

--  select has_column(       'ggircs_swrs', 'permit', 'path_context', 'permit.path_context column should exist');
select col_type_is(      'ggircs_swrs', 'permit', 'path_context', 'character varying(1000)', 'permit.path_context column should be type varchar');
select col_is_null(      'ggircs_swrs', 'permit', 'path_context', 'permit.path_context column should not allow null');
select col_hasnt_default('ggircs_swrs', 'permit', 'path_context', 'permit.path_context column should not have a default');

--  select has_column(       'ggircs_swrs', 'permit', 'permit_idx', 'permit.permit_idx column should exist');
select col_type_is(      'ggircs_swrs', 'permit', 'permit_idx', 'integer', 'permit.permit_idx column should be type integer');
select col_is_null(      'ggircs_swrs', 'permit', 'permit_idx', 'permit.permit_idx column should not allow null');
select col_hasnt_default('ggircs_swrs', 'permit', 'permit_idx', 'permit.permit_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'permit', 'issuing_agency', 'permit.issuing_agency column should exist');
select col_type_is(      'ggircs_swrs', 'permit', 'issuing_agency', 'character varying(1000)', 'permit.issuing_agency column should be type varchar');
select col_is_null(      'ggircs_swrs', 'permit', 'issuing_agency', 'permit.issuing_agency column should not allow null');
select col_hasnt_default('ggircs_swrs', 'permit', 'issuing_agency', 'permit.issuing_agency column should not have a default');

--  select has_column(       'ggircs_swrs', 'permit', 'issuing_dept_agency_program', 'permit.issuing_dept_agency_program column should exist');
select col_type_is(      'ggircs_swrs', 'permit', 'issuing_dept_agency_program', 'character varying(1000)', 'permit.issuing_dept_agency_program column should be type varchar');
select col_is_null(      'ggircs_swrs', 'permit', 'issuing_dept_agency_program', 'permit.issuing_dept_agency_program column should not allow null');
select col_hasnt_default('ggircs_swrs', 'permit', 'issuing_dept_agency_program', 'permit.issuing_dept_agency_program column should not have a default');

--  select has_column(       'ggircs_swrs', 'permit', 'permit_number', 'permit.permit_number column should exist');
select col_type_is(      'ggircs_swrs', 'permit', 'permit_number', 'character varying(1000)', 'permit.permit_number column should be type varchar');
select col_is_null(      'ggircs_swrs', 'permit', 'permit_number', 'permit.permit_number column should not allow null');
select col_hasnt_default('ggircs_swrs', 'permit', 'permit_number', 'permit.permit_number column should not have a default');


insert into ggircs_swrs.ghgr_import (xml_file) values ($$<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
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


refresh materialized view ggircs_swrs.facility with data;
refresh materialized view ggircs_swrs.permit with data;

select results_eq(
     $$select facility.swrs_facility_id from ggircs_swrs.permit
     join ggircs_swrs.facility
     on
     permit.ghgr_import_id = facility.ghgr_import_id$$,

    'select swrs_facility_id from ggircs_swrs.facility',

    'Foreign key ghgr_import_id in ggircs_swrs_parent_facility references ggircs_swrs.facility'
);

-- XML import tests
select results_eq(
    'select ghgr_import_id from ggircs_swrs.permit',
    'select id from ggircs_swrs.ghgr_import',
    'column ghgr_import_id in permit correctly parsed xml'
);

select results_eq(
    'select path_context from ggircs_swrs.permit',
    ARRAY['RegistrationData'::varchar],
    'column path_context in permit correctly parsed xml'
);

select results_eq(
    'select permit_idx from ggircs_swrs.permit',
    ARRAY[0::integer],
    'column permit_idx in permit correctly parsed xml'
);

select results_eq(
    'select issuing_agency from ggircs_swrs.permit',
    ARRAY['BC Ministry of Environment'::varchar],
    'column issuing_agency in permit correctly parsed xml'
);

select results_eq(
    'select issuing_dept_agency_program from ggircs_swrs.permit',
    ARRAY['abc'::varchar],
    'column issuing_dept_agency_program in permit correctly parsed xml'
);

select results_eq(
    'select permit_number from ggircs_swrs.permit',
    ARRAY['AB-12345'::varchar],
    'column permit_number in permit correctly parsed xml'
);

select * from finish();
rollback;
