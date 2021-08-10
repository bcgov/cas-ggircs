-- Revert ggircs:swrs/history/table/report from pg

BEGIN;

drop table swrs_history.report;

COMMIT;
