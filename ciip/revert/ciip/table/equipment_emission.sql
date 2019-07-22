-- Revert ggircs:ciip_table_equipment_emission from pg


begin;

drop table ciip.equipment_emission;

commit;
