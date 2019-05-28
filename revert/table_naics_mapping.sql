-- Revert ggircs:table_naics_mapping from pg

begin;

drop table ggircs_swrs.naics_mapping;

commit;
