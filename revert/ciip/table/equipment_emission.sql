-- Revert ggircs:ciip_table_equipment_emission from pg


begin;

drop table ciip_2018.equipment_emission;

commit;
