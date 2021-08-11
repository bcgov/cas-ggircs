-- Revert ggircs:swrs/history/table/report from pg

begin;

drop table swrs_history.report;

commit;
