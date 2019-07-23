-- Deploy ggircs:ciip_table_energy to pg
-- requires: ciip_table_application


begin;

create table ciip_2018.energy (
    id                        serial primary key,
    application_id            integer references ciip_2018.application(id),
    facility_id               integer references ciip_2018.facility(id),
    operator_id               integer references ciip_2018.operator(id),
    energy_type               varchar(1000),
    purchased_energy          numeric,
    generated_energy          numeric,
    consumed_energy           numeric,
    sold_energy               numeric,
    emissions_from_generated  numeric
);

create index ciip_energy_application_foreign_key on ciip_2018.energy(application_id);
create index ciip_energy_facility_foreign_key on ciip_2018.energy(facility_id);
create index ciip_energy_operator_foreign_key on ciip_2018.energy(operator_id);

comment on table ciip_2018.energy                           is 'The table containing the reported heat and electricity';
comment on column ciip_2018.energy.id                       is 'The primary key';
comment on column ciip_2018.energy.application_id           is 'The application id';
comment on column ciip_2018.energy.facility_id              is 'The facility id';
comment on column ciip_2018.energy.operator_id              is 'The operator id';
comment on column ciip_2018.energy.energy_type              is 'The type of energy (Heat or Electricity)';
comment on column ciip_2018.energy.purchased_energy         is 'The amount of purchased energy';
comment on column ciip_2018.energy.generated_energy         is 'The amount of generated energy';
comment on column ciip_2018.energy.consumed_energy          is 'The amount of consumed energy';
comment on column ciip_2018.energy.sold_energy              is 'The amonnt of generated energy';
comment on column ciip_2018.energy.emissions_from_generated is 'The emissions associated to the generated energy';

commit;
