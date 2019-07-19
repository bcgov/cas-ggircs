-- Revert ggircs:table_unit from pg

begin;

drop table ggircs_swrs_load.unit;

commit;
