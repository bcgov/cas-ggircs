-- Revert ggircs:table_fuel from pg

begin;

drop table ggircs_swrs_load.fuel;

commit;
