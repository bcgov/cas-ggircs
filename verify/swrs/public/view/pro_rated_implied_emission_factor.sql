-- Verify ggircs:view_pro_rated_implied_emission_factor on pg

begin;

select * from swrs.pro_rated_implied_emission_factor where false;

rollback;
