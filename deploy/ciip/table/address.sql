-- Deploy ggircs:ciip_table_address to pg
-- requires: ciip_table_application
-- requires: ciip_table_facility
-- requires: ciip_table_operator

begin;

create table ciip_2018.address (
    id                                                  serial primary key,
    application_id                                      integer references ciip_2018.application(id),
    facility_location_id                                integer references ciip_2018.facility(id),
    facility_mailing_id                                 integer references ciip_2018.facility(id),
    operator_id                                         integer references ciip_2018.operator(id),
    street_address                                      varchar(1000),
    municipality                                        varchar(1000),
    postal_code                                         varchar(1000),
    province                                            varchar(1000)
);

create index ciip_address_application_foreign_key on ciip_2018.address(application_id);
create index ciip_address_facility_location_foreign_key on ciip_2018.address(facility_location_id);
create index ciip_address_facility_mailing_foreign_key on ciip_2018.address(facility_mailing_id);
create index ciip_address_operator_foreign_key on ciip_2018.address(operator_id);

comment on table ciip_2018.address is 'The table housing address information for contacts, operator and facility of CIIP applications';
comment on column ciip_2018.address.id is 'The primary key';
comment on column ciip_2018.address.application_id is 'The id of the CIIP application';
comment on column ciip_2018.address.facility_location_id is 'The id of the facility, if this address is a facility location';
comment on column ciip_2018.address.facility_mailing_id is 'The id of the facility, if this address is a facility mailing address';
comment on column ciip_2018.address.operator_id is 'The id of the operator, if this address is an operator address';
comment on column ciip_2018.address.street_address is 'The street address, including number and unit';
comment on column ciip_2018.address.municipality is 'The municipality, city, or district';
comment on column ciip_2018.address.postal_code is 'The postal code';
comment on column ciip_2018.address.province is 'The province, territory or state';

commit;
