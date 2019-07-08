-- Deploy ggircs:ciip_table_contact to pg
-- requires: ciip_table_application
-- requires: ciip_table_facility
-- requires: ciip_table_address

begin;

create table ciip.contact (

    id                        serial primary key,
    application_id            integer references ciip.application(id),
    application_co_id         integer references ciip.application(id),
    address_id                integer references ciip.address(id),
    facility_id               integer references ciip.facility(id),
    facility_rep_id           integer references ciip.facility(id),
    operator_id               integer references ciip.operator(id),
    given_name                varchar(1000),
    family_name               varchar(1000),
    telephone_number          varchar(1000),
    fax_number                varchar(1000),
    email_address             varchar(1000),
    position                  varchar(1000)
);

create index ciip_contact_application_foreign_key on ciip.contact(application_id);
create index ciip_contact_application_co_foreign_key on ciip.contact(application_id);
create index ciip_contact_address_foreign_key on ciip.contact(address_id);
create index ciip_contact_facility_foreign_key on ciip.contact(facility_id);
create index ciip_contact_facility_rep_foreign_key on ciip.contact(facility_id);
create index ciip_contact_operator_foreign_key on ciip.contact(operator_id);

commit;