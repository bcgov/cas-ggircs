-- Revert ggircs:table_identifier from pg

begin;

drop table ggircs_swrs_load.identifier;

commit;
