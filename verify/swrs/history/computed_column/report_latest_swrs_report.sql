-- Verify ggircs:swrs/history/computed_column/report_latest_swrs_report on pg

begin;

select pg_get_functiondef('swrs_history.report_latest_swrs_report(swrs_history.report)'::regprocedure);

rollback;
