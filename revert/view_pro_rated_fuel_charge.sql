-- Revert ggircs:view_pro_rated_fuel_charge from pg

begin;

drop view if exists ggircs.pro_rated_fuel_charge;

commit;
