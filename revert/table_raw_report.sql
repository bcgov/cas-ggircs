-- Revert ggircs:table_raw_report from pg

BEGIN;

drop table ggircs_private.raw_report;

COMMIT;
