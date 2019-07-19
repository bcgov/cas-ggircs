-- Revert ggircs:table_emission from pg

begin;

drop table ggircs_swrs_load.emission;

commit;
