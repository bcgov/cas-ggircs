-- Verify ggircs:view_pro_rated_implied_emission_factor on pg

begin;

select * from ggircs_swrs_load.pro_rated_implied_emission_factor where false;

rollback;
