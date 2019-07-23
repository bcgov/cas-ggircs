-- Verify ggircs:function_load_emission on pg

begin;

select pg_get_functiondef('swrs_transform.load_emission()'::regprocedure);

rollback;
