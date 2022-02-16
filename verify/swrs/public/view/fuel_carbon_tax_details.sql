-- Verify ggircs:swrs/public/view/fuel_carbon_tax_details on pg

begin;

  select * from swrs.fuel_carbon_tax_details where false;

rollback;
