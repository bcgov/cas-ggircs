-- Revert ggircs:view_naics_mapping from pg

begin;

drop view if exists ggircs_swrs_load.naics_category_mapping;

commit;
