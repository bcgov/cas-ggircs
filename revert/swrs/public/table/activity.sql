-- Revert ggircs:table_activity from pg

begin;

drop table swrs.activity;

commit;
