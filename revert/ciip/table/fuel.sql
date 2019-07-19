-- Revert ggircs:ciip_table_fuel from pg

begin;

drop table ciip.fuel;

commit;
