-- Revert ggircs:swrs/utility/table/fuel_charge from pg

begin;

drop table swrs_utility.fuel_charge;

commit;
