-- Revert ggircs:table_fuel_charge from pg

begin;

drop table swrs.fuel_charge;

commit;
