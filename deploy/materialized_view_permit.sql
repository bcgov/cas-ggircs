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
                swrs_organisation_id numeric(1000,0) path './ancestor-or-self::ParentOrganisation/ancestor::ReportData/ReportDetails/OrganisationId[normalize-space(.)]',
                path_context varchar(1000) path 'name(./ancestor::VerifyTombstone|./ancestor::RegistrationData)',
                parent_organisation_idx integer path 'string(count(./ancestor-or-self::ParentOrganisation/preceding-sibling::ParentOrganisation))' not null,

         ) as permit_details
) with no data;

create unique index ggircs_permit_primary_key
    on ggircs_swrs.permit (ghgr_import_id);

comment on materialized view ggircs_swrs.parent_organisation is 'The materialized view housing parent organisation information';
comment on column ggircs_swrs.parent_organisation.ghgr_import_id is 'The foreign key reference to ggircs_swrs.ghgr_import';

commit;
