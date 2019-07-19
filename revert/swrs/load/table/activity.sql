-- Revert ggircs:table_activity from pg

begin;

drop table ggircs_swrs_load.activity;

commit;
