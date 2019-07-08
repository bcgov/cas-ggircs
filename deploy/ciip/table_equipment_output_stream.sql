-- Deploy ggircs:ciip_table_equipment_output_stream to pg
-- requires: ciip_table_application

begin;

create table ciip.equipment_output_stream (
    id                        serial primary key,
    application_id            integer references ciip.application(id),
    equipment_id              integer references ciip.equipment(id),
    output_stream_label       varchar(1000),
    output_stream_value       varchar(1000)
);

create index ciip_equipment_output_stream_application_foreign_key on ciip.equipment_output_stream(application_id);
create index ciip_equipment_output_stream_equipment_foreign_key on ciip.equipment_output_stream(equipment_id);

comment on table ciip.equipment_output_stream is 'The equipment output stream volumes information';
comment on column ciip.equipment_output_stream.id                  is 'The primary key';
comment on column ciip.equipment_output_stream.application_id      is 'The application id';
comment on column ciip.equipment_output_stream.equipment_id        is 'The equipment id';
comment on column ciip.equipment_output_stream.output_stream_label is 'The label of the ouput stream column';
comment on column ciip.equipment_output_stream.output_stream_value is 'The entered value';

commit;
