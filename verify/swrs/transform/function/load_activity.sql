-- Verify ggircs:function_load_activity on pg

begin;

select pg_get_functiondef('ggircs_swrs_transform.load_activity()'::regprocedure);

rollback;
