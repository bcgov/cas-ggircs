-- Revert ggircs:swrs/transform/function/load_fuel_carbon_tax_details from pg

begin;

drop function swrs_transform.load_fuel_carbon_tax_details;

commit;
