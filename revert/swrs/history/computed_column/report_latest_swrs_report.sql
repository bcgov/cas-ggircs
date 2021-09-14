-- Revert ggircs:swrs/history/computed_column/report_latest_swrs_report from pg

begin;

drop function swrs_history.report_latest_swrs_report;

commit;
