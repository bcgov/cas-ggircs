-- Revert ggircs:ciip_table_equipment from pg

begin;

drop table ciip_2018.equipment;

commit;
