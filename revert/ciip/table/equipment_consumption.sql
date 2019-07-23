-- Revert ggircs:ciip_table_equipment_consumption from pg


begin;

drop table ciip_2018.equipment_consumption;

commit;
