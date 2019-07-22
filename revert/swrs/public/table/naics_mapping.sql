-- Revert ggircs:table_naics_mapping from pg

begin;

drop table ggircs.naics_mapping;

commit;
