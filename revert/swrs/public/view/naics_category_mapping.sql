-- Revert ggircs:view_naics_mapping from pg

begin;

drop view if exists swrs.naics_category_mapping;

commit;
