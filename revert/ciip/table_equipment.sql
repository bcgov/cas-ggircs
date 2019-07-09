-- Revert ggircs:ciip_table_equipment from pg

begin;

drop table ciip.equipment;

commit;
