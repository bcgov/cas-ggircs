-- Verify ggircs:view_carbon_tax_calculation on pg

begin;

select * from ggircs_swrs_load.carbon_tax_calculation where false;

commit;
