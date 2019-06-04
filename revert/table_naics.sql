-- Revert ggircs:table_naics from pg

begin;

drop table ggircs.naics;

commit;
