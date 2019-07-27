-- Verify ggircs:function_load_unit on pg

begin;

select pg_get_functiondef('swrs_transform.load_unit()'::regprocedure);

rollback;
