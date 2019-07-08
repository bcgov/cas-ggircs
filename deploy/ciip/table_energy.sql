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

comment on table ciip.energy                           is 'The table containing the reported heat and electricity';
comment on column ciip.energy.id                       is 'The primary key';
comment on column ciip.energy.application_id           is 'The application id';
comment on column ciip.energy.energy_type              is 'The type of energy (Heat or Electricity)';
comment on column ciip.energy.purchased_energy         is 'The amount of purchased energy';
comment on column ciip.energy.generated_energy         is 'The amount of generated energy';
comment on column ciip.energy.consumed_energy          is 'The amount of consumed energy';
comment on column ciip.energy.sold_energy              is 'The amonnt of generated energy';
comment on column ciip.energy.emissions_from_generated is 'The emissions associated to the generated energy';

commit;
