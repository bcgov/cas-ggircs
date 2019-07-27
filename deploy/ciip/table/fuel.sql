-- Deploy ggircs:ciip_table_fuel to pg
-- requires: ciip_table_application

begin;

create table ciip_2018.fuel(
    id                        serial primary key,
    application_id            integer references ciip_2018.application(id),
    facility_id               integer references ciip_2018.facility(id),
    operator_id               integer references ciip_2018.operator(id),
    fuel_type                 varchar(1000),
    fuel_type_alt             varchar(1000),
    fuel_description          varchar(10000),
    quantity                  numeric,
    fuel_units                varchar(1000),
    carbon_emissions          numeric
);

create index ciip_fuel_application_foreign_key on ciip_2018.fuel(application_id);
create index ciip_fuel_facility_foreign_key on ciip_2018.fuel(facility_id);
create index ciip_fuel_operator_foreign_key on ciip_2018.fuel(operator_id);

comment on table ciip_2018.fuel is 'The fuel usage quantities for the reporting period';
comment on column ciip_2018.fuel.id               is 'The primary key';
comment on column ciip_2018.fuel.application_id   is 'The application id';
comment on column ciip_2018.fuel.facility_id         is 'The facility id';
comment on column ciip_2018.fuel.operator_id         is 'The operator id';
comment on column ciip_2018.fuel.fuel_type        is 'The fuel type';
comment on column ciip_2018.fuel.fuel_type_alt    is '__DEPRECATED__ A second field for the fuel type, present in some version of the application form';
comment on column ciip_2018.fuel.fuel_description is 'The description of the fuel';
comment on column ciip_2018.fuel.quantity         is 'The used quantity';
comment on column ciip_2018.fuel.fuel_units       is 'The units in which the quantity is reported';
comment on column ciip_2018.fuel.carbon_emissions is 'The associated carbon emissions (tCO2e)';

commit;
