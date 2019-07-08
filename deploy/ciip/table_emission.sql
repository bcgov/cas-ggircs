-- Deploy ggircs:ciip_table_emission to pg
-- requires: ciip_table_application


begin;

create table ciip.emission (
    id                        serial primary key,
    application_id            integer references ciip.application(id),
    gas_type                  varchar(1000),
    quantity                  numeric,
    calculated_quantity       numeric,
    emission_category         varchar(1000)
);

create index ciip_emission_application_foreign_key on ciip.emission(application_id);

comment on table ciip.emission is 'The table containing the emissions reported in a CIIP application';
comment on column ciip.emission.id                  is 'The primary key';
comment on column ciip.emission.application_id      is 'The application id';
comment on column ciip.emission.gas_type            is 'The emitted gas';
comment on column ciip.emission.quantity            is 'The reported quantity of emissions';
comment on column ciip.emission.calculated_quantity is 'The emitted CO2 equivalent';
comment on column ciip.emission.emission_category   is 'The category of the emission';


commit;
