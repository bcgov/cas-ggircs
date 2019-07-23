-- Verify ggircs:function_load_identifier on pg

begin;

select pg_get_functiondef('swrs_transform.load_identifier()'::regprocedure);

rollback;
