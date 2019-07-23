-- Revert ggircs:ciip_table_fuel from pg

begin;

drop table ciip_2018.fuel;

commit;
