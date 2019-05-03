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
                organisation_id numeric(1000,0) path './ancestor::Organisation/../../ReportDetails/OrganisationId[normalize-space(.)]',
                type varchar(1000) path 'name(..)',
                physical_address_municipality varchar(1000) path './PhysicalAddress/Municipality[normalize-space(.)]',
                physical_address_unit_number varchar(1000) path './PhysicalAddress/UnitNumber[normalize-space(.)]',
                physical_address_street_number varchar(1000) path './PhysicalAddress/StreetNumber[normalize-space(.)]',
                physical_address_street_number_suffix varchar(1000) path './PhysicalAddress/StreetNumberSuffix[normalize-space(.)]',
                physical_address_street_name varchar(1000) path './PhysicalAddress/StreetName[normalize-space(.)]',
                physical_address_street_type varchar(1000) path './PhysicalAddress/StreetType[normalize-space(.)]',
                physical_address_street_direction varchar(1000) path './PhysicalAddress/StreetDirection[normalize-space(.)]',
                physical_address_prov_terr_state varchar(1000) path './PhysicalAddress/ProvTerrState[normalize-space(.)]',
                physical_address_postal_code_zip_code varchar(1000) path './PhysicalAddress/PostalCodeZipCode[normalize-space(.)]',
                physical_address_country varchar(1000) path './PhysicalAddress/Country[normalize-space(.)]',
                physical_address_national_topographical_description varchar(1000) path './PhysicalAddress/NationalTopographicalDescription[normalize-space(.)]'

         ) as address_details
) with no data;

create unique index ggircs_adddress_primary_key on ggircs_swrs.address (id);

commit;
