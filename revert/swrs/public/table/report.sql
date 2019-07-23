-- Revert ggircs:table_report from pg

begin;

drop table swrs.report;

commit;
