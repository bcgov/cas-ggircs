-- Deploy ggircs:table_contact to pg
-- requires: schema_ggircs

begin;

create table swrs.contact (

    id                        integer primary key,
    report_id                 integer references swrs.report(id),
    address_id                integer references swrs.address(id),
    facility_id               integer references swrs.facility(id),
    eccc_xml_file_id            integer,
    organisation_id           integer,
    path_context              varchar(1000),
    contact_type              varchar(1000),
    given_name                varchar(1000),
    family_name               varchar(1000),
    initials                  varchar(1000),
    telephone_number          varchar(1000),
    extension_number          varchar(1000),
    fax_number                varchar(1000),
    email_address             varchar(1000),
    position                  varchar(1000),
    language_correspondence   varchar(1000)
);

create index ggircs_contact_report_foreign_key on swrs.contact(report_id);
create index ggircs_contact_address_foreign_key on swrs.contact(address_id);
create index ggircs_contact_facility_foreign_key on swrs.contact(facility_id);


comment on table swrs.contact is 'The table housing contact information';
comment on column swrs.contact.id is 'The primary key';
comment on column swrs.contact.report_id is 'A foreign key reference to swrs.report';
comment on column swrs.contact.address_id is 'A foreign key reference to swrs.address';
comment on column swrs.contact.facility_id is 'A foreign key reference to swrs.facility';
comment on column swrs.contact.eccc_xml_file_id is 'The foreign key reference to swrs.eccc_xml_file';
comment on column swrs.contact.organisation_id is 'A foreign key reference to swrs.organisation';
comment on column swrs.contact.path_context is 'The umbrella context from which the contact was pulled from the xml (VerifyTombstone or RegistrationData';
comment on column swrs.contact.contact_type is 'The type of contact';
comment on column swrs.contact.given_name is 'The given name of the contact';
comment on column swrs.contact.family_name is 'The family name of the contact';
comment on column swrs.contact.initials is 'The initials of the contact';
comment on column swrs.contact.telephone_number is 'The phone number attached to this contact';
comment on column swrs.contact.extension_number is 'The extension number attached to this contact';
comment on column swrs.contact.fax_number is 'The fax number attached to this contact';
comment on column swrs.contact.email_address is 'The email address attached to this contact';
comment on column swrs.contact.position is 'The position of this contact';
comment on column swrs.contact.language_correspondence is 'The language of correspondence for thsi contact';

commit;
