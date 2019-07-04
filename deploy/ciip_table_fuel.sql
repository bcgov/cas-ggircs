-- Deploy ggircs:ciip_table_fuel to pg
-- requires: ciip_table_application

begin;

create table ciip.fuel(
    id                        serial primary key,
    application_id            integer references ciip.application(id),
    fuel_type                 varchar(1000),
    fuel_type_alt             varchar(1000),
    fuel_description          varchar(10000),
    quantity                  numeric,
    fuel_units                varchar(1000),
    carbon_emissions          numeric
);

create index ciip_fuel_application_foreign_key on ciip.fuel(application_id);

commit;
