-- Verify ggircs:view_pro_rated_carbon_rate on pg

begin;

select * from swrs.pro_rated_carbon_tax_rate where false;

rollback;
