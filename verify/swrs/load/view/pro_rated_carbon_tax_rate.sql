-- Verify ggircs:view_pro_rated_carbon_rate on pg

begin;

select * from ggircs_swrs_load.pro_rated_carbon_tax_rate where false;

rollback;
