-- Revert ggircs:materialized_view_report from pg

BEGIN;

drop materialized view ggircs_private.report;

COMMIT;
