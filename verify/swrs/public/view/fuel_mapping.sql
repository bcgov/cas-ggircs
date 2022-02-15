-- Verify ggircs:swrs/public/view/fuel_mapping on pg

begin;

  select * from swrs.fuel_mapping where false;

rollback;
