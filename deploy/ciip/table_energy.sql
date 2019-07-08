-- Deploy ggircs:ciip_table_energy to pg
-- requires: ciip_table_application


begin;

create table ciip.energy (
    id                        serial primary key,
    application_id            integer references ciip.application(id),
    energy_type               varchar(1000),
    purchased_energy          numeric,
    generated_energy          numeric,
    consumed_energy           numeric,
    sold_energy               numeric,
    emissions_from_generated  numeric
);

create index ciip_energy_application_foreign_key on ciip.energy(application_id);

commit;
