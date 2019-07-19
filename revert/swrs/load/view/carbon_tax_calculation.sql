-- Revert ggircs:view_carbon_tax_calculation from pg

begin;

drop view if exists ggircs_swrs_load.carbon_tax_calculation;

commit;
