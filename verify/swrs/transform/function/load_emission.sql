-- Verify ggircs:function_load_emission on pg

begin;

select pg_get_functiondef('ggircs_swrs_transform.load_emission()'::regprocedure);

rollback;
