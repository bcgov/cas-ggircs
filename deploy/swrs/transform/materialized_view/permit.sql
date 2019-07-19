-- Deploy ggircs:materialized_view_permit to pg
-- requires: table_ghgr_import

begin;

create materialized view ggircs_swrs_transform.permit as (
  select row_number() over () as id, id as ghgr_import_id, permit_details.*
  from ggircs_swrs_extract.ghgr_import,
       xmltable(
           '//Permit'
           passing xml_file
           columns
                path_context varchar(1000) path 'name(./ancestor::VerifyTombstone|./ancestor::RegistrationData)',
                permit_idx integer path 'string(count(./ancestor-or-self::Permit/preceding-sibling::Permit))' not null,
                issuing_agency varchar(1000) path'./IssuingAgency[normalize-space(.)]',
                issuing_dept_agency_program varchar(1000) path'./IssuingDeptAgencyProgram[normalize-space(.)]',
                permit_number varchar(1000) path'./PermitNumber[normalize-space(.)]'
         ) as permit_details
) with no data;

create unique index ggircs_permit_primary_key
    on ggircs_swrs_transform.permit (ghgr_import_id, path_context, permit_idx);

comment on materialized view ggircs_swrs_transform.permit is 'The materialized view housing permit information';
comment on column ggircs_swrs_transform.permit.id is 'A generated index used for keying in the ggircs schema';
comment on column ggircs_swrs_transform.permit.ghgr_import_id is 'The foreign key reference to ggircs_swrs_extract.ghgr_import';
comment on column ggircs_swrs_transform.permit.path_context is 'The context of the parent path (from VerifyTombstone or RegistrationData';
comment on column ggircs_swrs_transform.permit.permit_idx is 'The number of preceding Permit siblings before this Permit';
comment on column ggircs_swrs_transform.permit.issuing_agency is 'The issuing agency for this permit';
comment on column ggircs_swrs_transform.permit.issuing_dept_agency_program is 'The issuing agency program for this permit';
comment on column ggircs_swrs_transform.permit.permit_number is 'The permit number';

commit;
