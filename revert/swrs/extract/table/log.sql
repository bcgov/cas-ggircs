-- Revert ggircs:table_log from pg

begin;

drop table swrs_extract.log;

commit;
