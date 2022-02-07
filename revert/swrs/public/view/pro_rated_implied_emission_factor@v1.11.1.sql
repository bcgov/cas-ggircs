-- Revert ggircs:view_pro_rated_implied_emission_factor from pg

begin;

drop view if exists swrs.pro_rated_implied_emission_factor;

commit;
