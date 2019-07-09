-- Revert ggircs:ciip_table_equipment_consumption from pg


begin;

drop table ciip.equipment_consumption;

commit;
