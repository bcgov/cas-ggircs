-- Revert ggircs:table_report from pg

begin;

drop table ggircs.report;

commit;
