-- Deploy ggircs:ciip_table_equipment_emission to pg
-- requires: ciip_table_application

begin;

create table ciip.equipment_emission (
    id                        serial primary key,
    application_id            integer references ciip.application(id),
    equipment_id              integer references ciip.equipment(id),
    processing_unit_id        integer references ciip.production(id),
    emission_allocation       numeric
);

create index ciip_equipment_emission_application_foreign_key on ciip.equipment_emission(application_id);
create index ciip_equipment_emission_equipment_foreign_key on ciip.equipment_emission(equipment_id);
create index ciip_equipment_emission_processing_unit_foreign_key on ciip.equipment_emission(processing_unit_id);

commit;
