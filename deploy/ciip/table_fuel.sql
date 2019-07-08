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

comment on table ciip.fuel is 'The fuel usage quantities for the reporting period';
comment on column ciip.fuel.id               is 'The primary key';
comment on column ciip.fuel.application_id   is 'The application id';
comment on column ciip.fuel.fuel_type        is 'The fuel type';
comment on column ciip.fuel.fuel_type_alt    is '__DEPRECATED__ A second field for the fuel type, present in some version of the application form';
comment on column ciip.fuel.fuel_description is 'The description of the fuel';
comment on column ciip.fuel.quantity         is 'The used quantity';
comment on column ciip.fuel.fuel_units       is 'The units in which the quantity is reported';
comment on column ciip.fuel.carbon_emissions is 'The associated carbon emissions (tCO2e)';

commit;
