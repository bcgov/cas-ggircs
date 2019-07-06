-- Deploy ggircs:ciip_table_equipment_consumption to pg
-- requires: ciip_table_application


begin;

create table ciip.equipment_consumption (
    id                        serial primary key,
    application_id            integer references ciip.application(id),
    equipment_id              integer references ciip.equipment(id),
    processing_unit_id        integer references ciip.production(id),
    processing_unit_name      varchar(1000),
    consumption_allocation    numeric
);

create index ciip_equipment_consumption_application_foreign_key on ciip.equipment_consumption(application_id);
create index ciip_equipment_consumption_equipment_foreign_key on ciip.equipment_consumption(equipment_id);
create index ciip_equipment_consumption_processing_unit_foreign_key on ciip.equipment_consumption(processing_unit_id);

commit;
