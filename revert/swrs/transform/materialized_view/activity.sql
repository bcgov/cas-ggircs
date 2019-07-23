-- Revert ggircs:materialized_view_activity from pg

BEGIN;

drop materialized view swrs_transform.activity;

COMMIT;
