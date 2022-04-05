-- Revert ggircs:swrs/public/view/carbon_tax_act_fuel_type from pg

begin;

drop view if exists swrs.carbon_tax_act_fuel_type;

commit;
