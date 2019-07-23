-- Verify ggircs:function_load on pg

BEGIN;

select pg_get_functiondef('ggircs_swrs_transform.load(boolean, boolean)'::regprocedure);

ROLLBACK;
