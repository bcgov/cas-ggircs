-- Revert ggircs:table_emission from pg

begin;

drop table swrs.emission;

commit;
