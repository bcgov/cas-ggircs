-- Revert ggircs:function_refresh_materialized_views from pg

BEGIN;

 drop function ggircs_swrs.refresh_materialized_views;

COMMIT;
