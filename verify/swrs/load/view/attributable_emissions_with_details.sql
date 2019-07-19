-- Verify ggircs:view_attributable_emissions_with_details on pg

begin;

select * from ggircs_swrs_load.attributable_emissions_with_details where false;

rollback;
