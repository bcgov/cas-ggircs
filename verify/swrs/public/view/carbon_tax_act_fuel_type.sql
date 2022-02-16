-- Verify ggircs:swrs/public/view/carbon_tax_act_fuel_type on pg

begin;

  select * from swrs.carbon_tax_act_fuel_type where false;

rollback;
