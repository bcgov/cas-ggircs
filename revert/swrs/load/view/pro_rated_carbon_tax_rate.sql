-- Revert ggircs:view_pro_rated_carbon_rate from pg

begin;

drop view if exists ggircs_swrs_load.pro_rated_carbon_tax_rate;

commit;
