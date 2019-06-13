-- Revert ggircs:view_pro_rated_implied_emission_factor from pg

begin;

drop view if exists ggircs.pro_rated_implied_emission_factor;

commit;

