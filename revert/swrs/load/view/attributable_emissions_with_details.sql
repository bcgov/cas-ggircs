-- Revert ggircs:view_attributable_emissions_with_details from pg

begin;

drop view if exists ggircs_swrs_load.attributable_emissions_with_details;

commit;
