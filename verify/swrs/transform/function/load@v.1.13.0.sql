-- Verify ggircs:function_load on pg

begin;

select pg_get_functiondef('swrs_transform.load(boolean, boolean)'::regprocedure);

rollback;
