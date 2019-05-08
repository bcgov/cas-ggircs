-- Deploy ggircs:materialized_view_address to pg
-- requires: table_ghgr_import

begin;

create materialized view ggircs_swrs.address as (
  with x as (
    select _ghgr_import.xml_file as source_xml,
           _ghgr_import.id         as ghgr_import_id
    from ggircs_swrs.ghgr_import as _ghgr_import
    order by ghgr_import_id asc
  )
  select ghgr_import_id, address_details.*
  from x,
       xmltable(
           '//Address[not(ancestor::Stack)]'
           passing source_xml
           columns
                facility_id numeric(1000,0) path './ancestor::Facility/../../ReportDetails/FacilityId[normalize-space(.)]|./ancestor::Contact/ancestor::ReportData/ReportDetails/FacilityId[normalize-space(.)]',
                organisation_id numeric(1000,0) path './ancestor::Organisation/../../ReportDetails/OrganisationId[normalize-space(.)]|./ancestor::ParentOrganisation/ancestor::ReportData/ReportDetails/OrganisationId[normalize-space(.)]',
                type varchar(1000) path 'name(..)',
                contact_idx integer path 'string(count(./ancestor::Contact/preceding-sibling::Contact))' not null,
                parent_organisation_idx integer path 'string(count(./ancestor::ParentOrganisation/preceding-sibling::ParentOrganisation))' not null,
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
                physical_address_national_topographical_description varchar(1000) path './PhysicalAddress/NationalTopographicalDescription[normalize-space(.)]',
                physical_address_additional_information varchar(10000) path './PhysicalAddress/AdditionalInformation[normalize-space(.)]',
                physical_address_land_survey_description varchar(1000) path './PhysicalAddress/LandSurveyDescription[normalize-space(.)]',

                mailing_address_delivery_mode varchar(1000) path './MailingAddress/DeliveryMode[normalize-space(.)]',
                mailing_address_po_box_number varchar(1000) path './MailingAddress/POBoxNumber[normalize-space(.)]',
                mailing_address_unit_number varchar(1000) path './MailingAddress/UnitNumber[normalize-space(.)]',
                mailing_address_rural_route_number varchar(1000) path './MailingAddress/RuralRouteNumber[normalize-space(.)]',
                mailing_address_street_number varchar(1000) path './MailingAddress/StreetNumber[normalize-space(.)]',
                mailing_address_street_number_suffix varchar(1000) path './MailingAddress/StreetNumberSuffix[normalize-space(.)]',
                mailing_address_street_name varchar(1000) path './MailingAddress/StreetName[normalize-space(.)]',
                mailing_address_street_type varchar(1000) path './MailingAddress/StreetType[normalize-space(.)]',
                mailing_address_street_direction varchar(1000) path './MailingAddress/StreetDirection[normalize-space(.)]',
                mailing_address_municipality varchar(1000) path './MailingAddress/Municipality[normalize-space(.)]',
                mailing_address_prov_terr_state varchar(1000) path './MailingAddress/ProvTerrState[normalize-space(.)]',
                mailing_address_postal_code_zip_code varchar(1000) path './MailingAddress/PostalCodeZipCode[normalize-space(.)]',
                mailing_address_country varchar(1000) path './MailingAddress/Country[normalize-space(.)]',
                mailing_address_additional_information varchar(10000) path './MailingAddress/AdditionalInformation[normalize-space(.)]',

                geographic_address_latitude varchar(1000) path './GeographicAddress/Latitude[normalize-space(.)]',
                geographic_address_longitude varchar(1000) path './GeographicAddress/Longitude[normalize-space(.)]'
         ) as address_details
) with no data;

-- THIS WILL FAIL
-- addresses for contacts are not currently covered with this materialized view
-- TODO: figure out what we are doing with addresses from contacts
create unique index ggircs_adddress_primary_key
    on ggircs_swrs.address (ghgr_import_id, facility_id, organisation_id, type, contact_idx, parent_organisation_idx);

comment on materialized view ggircs_swrs.address is 'The materialized view housing address information for facilities, organisations and contacts';
comment on column ggircs_swrs.address.ghgr_import_id is 'The foreign key that references ggircs_swrs.ghgr_import';
comment on column ggircs_swrs.address.facility_id is 'The foreign key that references ggircs_swrs.facility';
comment on column ggircs_swrs.address.organisation_id is 'The foreign key that references ggircs_swrs.organisation';
comment on column ggircs_swrs.address.type is 'What the address belongs to (facility, organisation, contact)';
comment on column ggircs_swrs.address.physical_address_municipality is 'The municipality according to the phsyical address';
comment on column ggircs_swrs.address.physical_address_unit_number is 'The unit number according to the phsyical address';
comment on column ggircs_swrs.address.physical_address_street_number is 'The street number according to the phsyical address';
comment on column ggircs_swrs.address.physical_address_street_number_suffix is 'The street number suffix according to the phsyical address';
comment on column ggircs_swrs.address.physical_address_street_name is 'The street name according to the phsyical address';
comment on column ggircs_swrs.address.physical_address_street_type is 'The street type according to the phsyical address';
comment on column ggircs_swrs.address.physical_address_street_direction is 'The street direction according to the phsyical address';
comment on column ggircs_swrs.address.physical_address_prov_terr_state is 'The province or territory according to the phsyical address';
comment on column ggircs_swrs.address.physical_address_postal_code_zip_code is 'The postal code according to the phsyical address';
comment on column ggircs_swrs.address.physical_address_country is 'The country according to the phsyical address';
comment on column ggircs_swrs.address.physical_address_national_topographical_description is 'The national topographical description according to the phsyical address';
comment on column ggircs_swrs.address.physical_address_additional_information is 'The additional information attached to the phsyical address';
comment on column ggircs_swrs.address.physical_address_land_survey_description is 'The land survey description according to the phsyical address';

comment on column ggircs_swrs.address.mailing_address_delivery_mode is 'The delivery mode according to the mailing address';
comment on column ggircs_swrs.address.mailing_address_po_box_number is 'The po box number according to the mailing address';
comment on column ggircs_swrs.address.mailing_address_unit_number is 'The unit number according to the mailing address';
comment on column ggircs_swrs.address.mailing_address_rural_route_number is 'The rural route number according to the mailing address';
comment on column ggircs_swrs.address.mailing_address_street_number is 'The street number according to the mailing address';
comment on column ggircs_swrs.address.mailing_address_street_number_suffix is 'The street number suffix according to the mailing address';
comment on column ggircs_swrs.address.mailing_address_street_name is 'The street name according to the mailing address';
comment on column ggircs_swrs.address.mailing_address_street_type is 'The street type according to the mailing address';
comment on column ggircs_swrs.address.mailing_address_street_direction is 'The street direction according to the mailing address';
comment on column ggircs_swrs.address.mailing_address_municipality is 'The municipality according to the mailing address';
comment on column ggircs_swrs.address.mailing_address_prov_terr_state is 'The province or territory according to the mailing address';
comment on column ggircs_swrs.address.mailing_address_postal_code_zip_code is 'The postal code according to the mailing address';
comment on column ggircs_swrs.address.mailing_address_country is 'The country according to the mailing address';
comment on column ggircs_swrs.address.mailing_address_additional_information is 'The additional information attached to the mailing address';

comment on column ggircs_swrs.address.geographic_address_latitude is 'The latitude of the address';
comment on column ggircs_swrs.address.geographic_address_longitude is 'The longitude of the address';

commit;
