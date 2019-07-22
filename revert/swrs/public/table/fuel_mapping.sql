-- Revert ggircs:table_fuel_mapping from pg

begin;

drop table ggircs.fuel_mapping;

commit;
