-- Verify ggircs:swrs/public/view/fuel_charge on pg

begin;

  select * from swrs.fuel_charge where false;

rollback;
