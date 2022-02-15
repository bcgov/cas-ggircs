-- Revert ggircs:swrs/public/view/fuel_charge from pg

begin;

drop view if exists swrs.fuel_charge;

commit;
