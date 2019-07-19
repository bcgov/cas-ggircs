-- Revert ggircs:ciip/view_compare_ciip_swrs_emission from pg

begin;

drop view if exists ciip.compare_ciip_swrs_emission;

commit;
