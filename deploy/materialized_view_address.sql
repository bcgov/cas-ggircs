-- Deploy ggircs:materialized_view_address to pg
-- requires: materialized_view_facility
-- requires: materialized_view_organisation

begin;

create materialized view ggircs_swrs.address as (
  with x as (
    select _ghgr_import.xml_file as source_xml,
           _ghgr_import.id         as ghgr_import_id,
           _ghgr_import.imported_at
    from ggircs_swrs.ghgr_import as _ghgr_import
    order by _ghgr_import.id asc
  )
  select row_number() over (order by ghgr_import_id asc) as id,
         x.ghgr_import_id,
         address_details.*
  from x,
       xmltable(
           '//Address'
           passing source_xml
           columns
                facility_id numeric(1000,0) path './ancestor::Facility/../../ReportDetails/FacilityId[normalize-space(.)]',
                organisation_id numeric(1000,0) path './ancestor::Organisation/../../ReportDetails/FacilityId[normalize-space(.)]',
                physical_address_municipality varchar(1000) path './PhysicalAddress/Municipality[normalize-space(.)]'

         ) as address_details
) with no data;

-- create unique index ggircs_identifier_primary_key on ggircs_swrs.identifier (id);
-- create index ggircs_swrs_identifier_history on ggircs_swrs.identifier (swrs_identifier_history_id);

commit;
