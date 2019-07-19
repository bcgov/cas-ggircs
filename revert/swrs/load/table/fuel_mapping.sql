-- Revert ggircs:table_fuel_mapping from pg

begin;

drop table ggircs_swrs_load.fuel_mapping;

commit;
