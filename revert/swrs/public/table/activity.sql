-- Revert ggircs:table_activity from pg

begin;

drop table ggircs.activity;

commit;
