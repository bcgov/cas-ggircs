-- Revert ggircs:view_pro_rated_carbon_rate from pg

begin;

drop view if exists ggircs.pro_rated_carbon_rate;

commit;
