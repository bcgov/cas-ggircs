-- Verify ggircs:view_carbon_tax_calculation on pg

begin;

drop view if exists ggircs.carbon_tax_calculation;

commit;
