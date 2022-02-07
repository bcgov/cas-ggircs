-- Revert ggircs:view_pro_rated_carbon_rate from pg

begin;

drop view if exists swrs.pro_rated_carbon_tax_rate;

commit;
