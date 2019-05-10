-- Deploy ggircs:materialized_view_permit to pg
-- requires: table_ghgr_import

begin;

create materialized view ggircs_swrs.permit as (
  with x as (
    select _ghgr_import.xml_file as source_xml,
           _ghgr_import.id         as ghgr_import_id
    from ggircs_swrs.ghgr_import as _ghgr_import
    order by ghgr_import_id asc
  )
  select ghgr_import_id, permit_details.*
  from x,
       xmltable(
           '//Permit'
           passing source_xml
           columns
                path_context varchar(1000) path 'name(./ancestor::VerifyTombstone|./ancestor::RegistrationData)',
                permit_idx integer path 'string(count(./ancestor-or-self::Permit/preceding-sibling::Permit))' not null,
                issuing_agency varchar(1000) path'./IssuingAgency[normalize-space(.)]',
                issuing_dept_agency_program varchar(1000) path'./IssuingDeptAgencyProgram[normalize-space(.)]',
                permit_number varchar(1000) path'./PermitNumber[normalize-space(.)]'

         ) as permit_details
) with no data;

create unique index ggircs_permit_primary_key
    on ggircs_swrs.permit (ghgr_import_id, path_context, permit_idx);

comment on materialized view ggircs_swrs.permit is 'The materialized view housing permit information';
comment on column ggircs_swrs.permit.ghgr_import_id is 'The foreign key reference to ggircs_swrs.ghgr_import';
comment on column ggircs_swrs.permit.path_context is 'The context of the parent path (from VerifyTombstone or RegistrationData';
comment on column ggircs_swrs.permit.permit_idx is 'The number of preceding Permit siblings before this Permit';
comment on column ggircs_swrs.permit.issuing_agency is 'The issuing agency for this permit';
comment on column ggircs_swrs.permit.issuing_dept_agency_program is 'The issuing agency program for this permit';
comment on column ggircs_swrs.permit.permit_number is 'The permit number';

commit;
