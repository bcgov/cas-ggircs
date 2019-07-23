-- Revert ggircs:table_fuel_mapping from pg

begin;

drop table swrs.fuel_mapping;

commit;
