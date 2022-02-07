-- Verify ggircs:function_load on pg

BEGIN;

select pg_get_functiondef('swrs_transform.load(boolean, boolean)'::regprocedure);

ROLLBACK;
