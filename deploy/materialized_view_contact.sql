-- Deploy ggircs:materialized_view_contact to pg
-- requires: table_ghgr_import

begin;

create materialized view ggircs_swrs.contact as (
  with x as (
    select _ghgr_import.xml_file as source_xml,
           _ghgr_import.id         as ghgr_import_id
    from ggircs_swrs.ghgr_import as _ghgr_import
    order by ghgr_import_id asc
  )
  select ghgr_import_id, contact_details.*
  from x,
       xmltable(
           '//Address[not(ancestor::Stack)]'
           passing source_xml
           columns
                facility_id numeric(1000,0) path './ancestor::Facility/../../ReportDetails/FacilityId[normalize-space(.)]|./ancestor::Contact/ancestor::ReportData/ReportDetails/FacilityId[normalize-space(.)]',
                contact_idx integer path 'string(count(./ancestor::Contact/preceding-sibling::Contact))' not null,
                parent_organisation_idx integer path 'string(count(./ancestor::ParentOrganisation/preceding-sibling::ParentOrganisation))' not null,
         ) as contact_details
) with no data;

create unique index ggircs_contact_primary_key
    on ggircs_swrs.contact (ghgr_import_id);

comment on materialized view ggircs_swrs.address is 'The materialized view housing contact information';

commit;

