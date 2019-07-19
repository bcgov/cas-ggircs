-- Revert ggircs:view_pro_rated_implied_emission_factor from pg

begin;

drop view if exists ggircs_swrs_load.pro_rated_implied_emission_factor;

commit;

