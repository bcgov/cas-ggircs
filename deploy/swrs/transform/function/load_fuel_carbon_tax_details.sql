-- Deploy ggircs:swrs/transform/function/load_fuel_carbon_tax_details to pg
-- requires: swrs/transform/schema
-- requires: swrs/public/table/fuel_carbon_tax_details

begin;

drop function swrs_transform.load_fuel_carbon_tax_details;

commit;
