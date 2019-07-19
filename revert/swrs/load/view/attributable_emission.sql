-- Revert ggircs:view_attributable_emission from pg

begin;

drop view if exists ggircs_swrs_load.attributable_emission;

commit;
