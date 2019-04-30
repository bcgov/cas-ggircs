-- Revert ggircs:materialized_view_activity from pg

BEGIN;

drop materialized view ggircs_swrs.activity;

COMMIT;
