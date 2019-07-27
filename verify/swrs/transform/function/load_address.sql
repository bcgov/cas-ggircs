-- Verify ggircs:function_load_address on pg

begin;

select pg_get_functiondef('swrs_transform.load_address()'::regprocedure);

rollback;
