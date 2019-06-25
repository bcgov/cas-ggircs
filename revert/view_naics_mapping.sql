-- Revert ggircs:view_naics_mapping from pg

begin;

drop view if exists ggircs.naics_mapping;

commit;
