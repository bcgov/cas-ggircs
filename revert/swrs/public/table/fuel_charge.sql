-- Revert ggircs:table_fuel_charge from pg

begin;

drop table ggircs.fuel_charge;

commit;
