-- Revert ggircs:table_emission from pg

begin;

drop table ggircs.emission;

commit;
