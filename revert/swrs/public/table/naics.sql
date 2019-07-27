-- Revert ggircs:table_naics from pg

begin;

drop table swrs.naics;

commit;
