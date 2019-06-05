-- Deploy ggircs:table_contact to pg
-- requires: schema_ggircs

begin;

create table ggircs.contact (

    id                        integer primary key,
    ghgr_import_id            integer,
    address_id                integer,
    facility_id               integer,
    report_id                 integer,
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

comment on table ggircs.contact is 'The table housing contact information';
comment on column ggircs.contact.id is 'The primary key';
comment on column ggircs.contact.ghgr_import_id is 'The foreign key reference to ggircs.ghgr_import';
comment on column ggircs.contact.address_id is 'A foreign key reference to ggircs.address';
comment on column ggircs.contact.facility_id is 'A foreign key reference to ggircs.facility';
comment on column ggircs.contact.report_id is 'A foreign key reference to ggircs.report';
comment on column ggircs.contact.path_context is 'The umbrella context from which the contact was pulled from the xml (VerifyTombstone or RegistrationData';
comment on column ggircs.contact.contact_type is 'The type of contact';
comment on column ggircs.contact.given_name is 'The given name of the contact';
comment on column ggircs.contact.family_name is 'The family name of the contact';
comment on column ggircs.contact.initials is 'The initials of the contact';
comment on column ggircs.contact.telephone_number is 'The phone number attached to this contact';
comment on column ggircs.contact.extension_number is 'The extension number attached to this contact';
comment on column ggircs.contact.fax_number is 'The fax number attached to this contact';
comment on column ggircs.contact.email_address is 'The email address attached to this contact';
comment on column ggircs.contact.position is 'The position of this contact';
comment on column ggircs.contact.language_correspondence is 'The language of correspondence for thsi contact';

commit;
