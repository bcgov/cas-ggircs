-- Verify ggircs:function_load_naics on pg

begin;

select pg_get_functiondef('ggircs_swrs_transform.load_naics()'::regprocedure);

rollback;
