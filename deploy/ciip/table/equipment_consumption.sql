-- Deploy ggircs:ciip_table_equipment_consumption to pg
-- requires: ciip_table_application


begin;

create table ciip_2018.equipment_consumption (
    id                        serial primary key,
    application_id            integer references ciip_2018.application(id),
    equipment_id              integer references ciip_2018.equipment(id),
    processing_unit_id        integer references ciip_2018.production(id),
    processing_unit_name      varchar(1000),
    consumption_allocation    numeric
);

create index ciip_equipment_consumption_application_foreign_key on ciip_2018.equipment_consumption(application_id);
create index ciip_equipment_consumption_equipment_foreign_key on ciip_2018.equipment_consumption(equipment_id);
create index ciip_equipment_consumption_processing_unit_foreign_key on ciip_2018.equipment_consumption(processing_unit_id);

comment on table ciip_2018.equipment_consumption is 'The table containing the equipment consumption data';
comment on column ciip_2018.equipment_consumption.id                     is 'The primary key';
comment on column ciip_2018.equipment_consumption.application_id         is 'The application id';
comment on column ciip_2018.equipment_consumption.equipment_id           is 'The id of the equipment';
comment on column ciip_2018.equipment_consumption.processing_unit_id     is 'The id of the processing unit';
comment on column ciip_2018.equipment_consumption.processing_unit_name   is '__DEPRECATED__ The name of the processing unit __This is temporarily required as some consumption information was declared without an associated production__';
comment on column ciip_2018.equipment_consumption.consumption_allocation is 'The allocated amount for the given equipment and processing unit';

commit;
