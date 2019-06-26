-- Deploy ggircs:ciip_table_facility to pg
-- requires: ciip_table_application
-- requires: ciip_table_operator

begin;

create table ciip.facility
(
    id                        serial primary key,
    application_id            integer references ciip.application(id),
    operator_id               integer references ciip.operator(id),
    swrs_facility_id          integer,
    facility_name             varchar(1000),
    facility_type             varchar(1000),
    bc_ghg_id                 varchar(1000),
    facility_description      varchar(10000),
    naics                     integer
);

create index ciif_facility_application_foreign_key on ciip.facility(application_id);
create index ciif_facility_operator_foreign_key on ciip.facility(operator_id);

commit;
