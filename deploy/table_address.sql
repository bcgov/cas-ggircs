-- Deploy ggircs:table_address to pg
-- requires: schema_ggircs

begin;

create table ggircs.address (

    id                                                  integer primary key,
    ghgr_import_id                                      integer,
    contact_idx                                         integer,
    parent_organisation_idx                             integer,
    swrs_facility_id                                    integer,
    swrs_organisation_id                                integer,
    path_context                                        varchar(1000),
    type                                                varchar(1000),
    physical_address_municipality                       varchar(1000),
    physical_address_unit_number                        varchar(1000),
    physical_address_street_number                      varchar(1000),
    physical_address_street_number_suffix               varchar(1000),
    physical_address_street_name                        varchar(1000),
    physical_address_street_type                        varchar(1000),
    physical_address_street_direction                   varchar(1000),
    physical_address_prov_terr_state                    varchar(1000),
    physical_address_postal_code_zip_code               varchar(1000),
    physical_address_country                            varchar(1000),
    physical_address_national_topographical_description varchar(1000),
    physical_address_additional_information             varchar(10000),
    physical_address_land_survey_description            varchar(1000),

    mailing_address_delivery_mode                       varchar(1000),
    mailing_address_po_box_number                       varchar(1000),
    mailing_address_unit_number                         varchar(1000),
    mailing_address_rural_route_number                  varchar(1000),
    mailing_address_street_number                       varchar(1000),
    mailing_address_street_number_suffix                varchar(1000),
    mailing_address_street_name                         varchar(1000),
    mailing_address_street_type                         varchar(1000),
    mailing_address_street_direction                    varchar(1000),
    mailing_address_municipality                        varchar(1000),
    mailing_address_prov_terr_state                     varchar(1000),
    mailing_address_postal_code_zip_code                varchar(1000),
    mailing_address_country                             varchar(1000),
    mailing_address_additional_information              varchar(10000),

    geographic_address_latitude                         numeric,
    geographic_address_longitude                        numeric
);

comment on table ggircs.address is 'The table housing address information for facilities, organisations and contacts';
comment on column ggircs.address.id is 'The primary key';
comment on column ggircs.address.ghgr_import_id is 'The foreign key that references ggircs.ghgr_import';
comment on column ggircs.address.swrs_facility_id is 'The foreign key that references ggircs.facility';
comment on column ggircs.address.swrs_organisation_id is 'The foreign key that references ggircs.organisation';
comment on column ggircs.address.path_context is 'The ancestor path context (VerifyTombstone or RegistrationData)';
comment on column ggircs.address.type is 'What the address belongs to (facility, organisation, contact)';
comment on column ggircs.address.physical_address_municipality is 'The municipality according to the phsyical address';
comment on column ggircs.address.physical_address_unit_number is 'The unit number according to the phsyical address';
comment on column ggircs.address.physical_address_street_number is 'The street number according to the phsyical address';
comment on column ggircs.address.physical_address_street_number_suffix is 'The street number suffix according to the phsyical address';
comment on column ggircs.address.physical_address_street_name is 'The street name according to the phsyical address';
comment on column ggircs.address.physical_address_street_type is 'The street type according to the phsyical address';
comment on column ggircs.address.physical_address_street_direction is 'The street direction according to the phsyical address';
comment on column ggircs.address.physical_address_prov_terr_state is 'The province or territory according to the phsyical address';
comment on column ggircs.address.physical_address_postal_code_zip_code is 'The postal code according to the phsyical address';
comment on column ggircs.address.physical_address_country is 'The country according to the phsyical address';
comment on column ggircs.address.physical_address_national_topographical_description is 'The national topographical description according to the phsyical address';
comment on column ggircs.address.physical_address_additional_information is 'The additional information attached to the phsyical address';
comment on column ggircs.address.physical_address_land_survey_description is 'The land survey description according to the phsyical address';

comment on column ggircs.address.mailing_address_delivery_mode is 'The delivery mode according to the mailing address';
comment on column ggircs.address.mailing_address_po_box_number is 'The po box number according to the mailing address';
comment on column ggircs.address.mailing_address_unit_number is 'The unit number according to the mailing address';
comment on column ggircs.address.mailing_address_rural_route_number is 'The rural route number according to the mailing address';
comment on column ggircs.address.mailing_address_street_number is 'The street number according to the mailing address';
comment on column ggircs.address.mailing_address_street_number_suffix is 'The street number suffix according to the mailing address';
comment on column ggircs.address.mailing_address_street_name is 'The street name according to the mailing address';
comment on column ggircs.address.mailing_address_street_type is 'The street type according to the mailing address';
comment on column ggircs.address.mailing_address_street_direction is 'The street direction according to the mailing address';
comment on column ggircs.address.mailing_address_municipality is 'The municipality according to the mailing address';
comment on column ggircs.address.mailing_address_prov_terr_state is 'The province or territory according to the mailing address';
comment on column ggircs.address.mailing_address_postal_code_zip_code is 'The postal code according to the mailing address';
comment on column ggircs.address.mailing_address_country is 'The country according to the mailing address';
comment on column ggircs.address.mailing_address_additional_information is 'The additional information attached to the mailing address';

comment on column ggircs.address.geographic_address_latitude is 'The latitude of the address';
comment on column ggircs.address.geographic_address_longitude is 'The longitude of the address';

commit;
