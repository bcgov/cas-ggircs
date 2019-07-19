-- Revert ggircs:table_naics_mapping from pg

begin;

drop table ggircs_swrs_load.naics_mapping;

commit;
