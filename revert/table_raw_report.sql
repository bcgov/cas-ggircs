-- Revert ggircs:table_raw_report from pg

BEGIN;

drop table ggircs_swrs.raw_report;

COMMIT;
