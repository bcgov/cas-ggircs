-- Revert ggircs:swrs/public/view/fuel_carbon_tax_details from pg

begin;

drop view if exists swrs.fuel_carbon_tax_details;

commit;
