-- Verify ggircs:view_carbon_tax_calculation on pg

begin;

select * from ggircs.carbon_tax_calculation where false;

commit;
