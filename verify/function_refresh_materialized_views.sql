-- Verify ggircs:function_refresh_materialized_views on pg

BEGIN;

select pg_get_functiondef('ggircs_swrs.refresh_materialized_views(boolean)'::regprocedure);

ROLLBACK;
