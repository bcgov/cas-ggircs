-- Revert ggircs:ciip_table_equipment_output_stream from pg


begin;

drop table ciip_2018.equipment_output_stream;

commit;
