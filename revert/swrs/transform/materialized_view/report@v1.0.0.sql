-- Revert ggircs:materialized_view_report from pg

BEGIN;

drop materialized view swrs_transform.report;

COMMIT;
