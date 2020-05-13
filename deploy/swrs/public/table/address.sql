-- Deploy ggircs:table_address to pg
-- requires: schema_ggircs

begin;

create table swrs.address (

    id                                                  integer primary key,
    report_id                                           integer references swrs.report(id),
    facility_id                                         integer references swrs.facility(id),
    organisation_id                                     integer references swrs.organisation(id),
    parent_organisation_id                              integer references swrs.parent_organisation(id),
    eccc_xml_file_id                                      integer,
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

create index ggircs_address_report_foreign_key on swrs.address(report_id);
create index ggircs_address_facility_foreign_key on swrs.address(facility_id);
create index ggircs_address_organisation_foreign_key on swrs.address(organisation_id);
create index ggircs_address_parent_organisation_foreign_key on swrs.address(parent_organisation_id);

comment on table swrs.address is 'The table housing address information for facilities, organisations and contacts';
comment on column swrs.address.id is 'The primary key';
comment on column swrs.address.eccc_xml_file_id is 'The foreign key that references swrs.eccc_xml_file';
comment on column swrs.address.facility_id is 'A foreign key reference to swrs.facility';
comment on column swrs.address.organisation_id is 'A foreign key reference to swrs.organisation';
comment on column swrs.address.parent_organisation_id is 'A foreign key reference to swrs.parent_organisation';
comment on column swrs.address.report_id is 'A foreign key reference to swrs.report';
comment on column swrs.address.swrs_facility_id is 'The foreign key that references swrs.facility';
comment on column swrs.address.swrs_organisation_id is 'The foreign key that references swrs.organisation';
comment on column swrs.address.path_context is 'The ancestor path context (VerifyTombstone or RegistrationData)';
comment on column swrs.address.type is 'What the address belongs to (facility, organisation, contact)';
comment on column swrs.address.physical_address_municipality is 'The municipality according to the phsyical address';
comment on column swrs.address.physical_address_unit_number is 'The unit number according to the phsyical address';
comment on column swrs.address.physical_address_street_number is 'The street number according to the phsyical address';
comment on column swrs.address.physical_address_street_number_suffix is 'The street number suffix according to the phsyical address';
comment on column swrs.address.physical_address_street_name is 'The street name according to the phsyical address';
comment on column swrs.address.physical_address_street_type is 'The street type according to the phsyical address';
comment on column swrs.address.physical_address_street_direction is 'The street direction according to the phsyical address';
comment on column swrs.address.physical_address_prov_terr_state is 'The province or territory according to the phsyical address';
comment on column swrs.address.physical_address_postal_code_zip_code is 'The postal code according to the phsyical address';
comment on column swrs.address.physical_address_country is 'The country according to the phsyical address';
comment on column swrs.address.physical_address_national_topographical_description is 'The national topographical description according to the phsyical address';
comment on column swrs.address.physical_address_additional_information is 'The additional information attached to the phsyical address';
comment on column swrs.address.physical_address_land_survey_description is 'The land survey description according to the phsyical address';

comment on column swrs.address.mailing_address_delivery_mode is 'The delivery mode according to the mailing address';
comment on column swrs.address.mailing_address_po_box_number is 'The po box number according to the mailing address';
comment on column swrs.address.mailing_address_unit_number is 'The unit number according to the mailing address';
comment on column swrs.address.mailing_address_rural_route_number is 'The rural route number according to the mailing address';
comment on column swrs.address.mailing_address_street_number is 'The street number according to the mailing address';
comment on column swrs.address.mailing_address_street_number_suffix is 'The street number suffix according to the mailing address';
comment on column swrs.address.mailing_address_street_name is 'The street name according to the mailing address';
comment on column swrs.address.mailing_address_street_type is 'The street type according to the mailing address';
comment on column swrs.address.mailing_address_street_direction is 'The street direction according to the mailing address';
comment on column swrs.address.mailing_address_municipality is 'The municipality according to the mailing address';
comment on column swrs.address.mailing_address_prov_terr_state is 'The province or territory according to the mailing address';
comment on column swrs.address.mailing_address_postal_code_zip_code is 'The postal code according to the mailing address';
comment on column swrs.address.mailing_address_country is 'The country according to the mailing address';
comment on column swrs.address.mailing_address_additional_information is 'The additional information attached to the mailing address';

comment on column swrs.address.geographic_address_latitude is 'The latitude of the address';
comment on column swrs.address.geographic_address_longitude is 'The longitude of the address';

commit;
