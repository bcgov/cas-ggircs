-- Revert ggircs:table_fuel_charge from pg

begin;

drop table ggircs_swrs_load.fuel_charge;

commit;
