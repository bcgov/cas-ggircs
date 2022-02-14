-- Revert ggircs:swrs/transform/function/load_carbon_tax_act_fuel_type from pg

begin;

drop function swrs_transform.load_carbon_tax_act_fuel_type;

commit;
