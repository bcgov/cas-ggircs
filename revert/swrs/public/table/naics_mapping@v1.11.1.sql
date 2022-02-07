-- Revert ggircs:table_naics_mapping from pg

begin;

drop table swrs.naics_mapping;

commit;
