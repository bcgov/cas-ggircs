-- Deploy ggircs:ciip_table_equipment_emission to pg
-- requires: ciip_table_application

begin;

create table ciip_2018.equipment_emission (
    id                        serial primary key,
    application_id            integer references ciip_2018.application(id),
    equipment_id              integer references ciip_2018.equipment(id),
    processing_unit_id        integer references ciip_2018.production(id),
    processing_unit_name      varchar(1000),
    emission_allocation       numeric
);

create index ciip_equipment_emission_application_foreign_key on ciip_2018.equipment_emission(application_id);
create index ciip_equipment_emission_equipment_foreign_key on ciip_2018.equipment_emission(equipment_id);
create index ciip_equipment_emission_processing_unit_foreign_key on ciip_2018.equipment_emission(processing_unit_id);

comment on table ciip_2018.equipment_emission is 'The table containing the equipment GHG emissions allocations';
comment on column ciip_2018.equipment_emission.id                   is 'The primary key';
comment on column ciip_2018.equipment_emission.application_id       is 'The application id';
comment on column ciip_2018.equipment_emission.equipment_id         is 'The equipment id';
comment on column ciip_2018.equipment_emission.processing_unit_id   is 'The id of the processing unit';
comment on column ciip_2018.equipment_emission.processing_unit_name is '__DEPRECATED__ The name of the processing unit __This is temporarily required as some consumption information was declared without an associated production__';
comment on column ciip_2018.equipment_emission.emission_allocation  is 'The GHG emission for the given equipment an processing unit';

commit;
