-- Verify ggircs:view_pro_rated_fuel_charge on pg

begin;

select * from swrs.pro_rated_fuel_charge where false;

rollback;
