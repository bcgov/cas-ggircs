-- Revert ggircs:view_carbon_tax_calculation from pg

begin;

drop view if exists ggircs.carbon_tax_calculation;

commit;
