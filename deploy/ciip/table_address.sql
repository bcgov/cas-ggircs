-- Deploy ggircs:ciip_table_address to pg
-- requires: ciip_table_application
-- requires: ciip_table_facility
-- requires: ciip_table_operator

begin;

create table ciip.address (
    id                                                  serial primary key,
    application_id                                      integer references ciip.application(id),
    facility_location_id                                integer references ciip.facility(id),
    facility_mailing_id                                 integer references ciip.facility(id),
    operator_id                                         integer references ciip.operator(id),
    swrs_facility_id                                    integer,
    swrs_operator_id                                    integer,
    street_address                                      varchar(1000),
    municipality                                        varchar(1000),
    postal_code                                         varchar(1000),
    province                                            varchar(1000)
);

create index ciip_address_application_foreign_key on ciip.address(application_id);
create index ciip_address_facility_location_foreign_key on ciip.address(facility_location_id);
create index ciip_address_facility_mailing_foreign_key on ciip.address(facility_mailing_id);
create index ciip_address_operator_foreign_key on ciip.address(operator_id);

commit;
