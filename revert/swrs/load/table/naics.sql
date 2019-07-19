-- Revert ggircs:table_naics from pg

begin;

drop table ggircs_swrs_load.naics;

commit;
