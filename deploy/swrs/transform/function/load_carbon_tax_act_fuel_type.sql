-- Deploy ggircs:swrs/transform/function/load_carbon_tax_act_fuel_type to pg
-- requires: swrs/public/table/carbon_tax_act_fuel_type

begin;

drop function swrs_transform.load_carbon_tax_act_fuel_type;

commit;
