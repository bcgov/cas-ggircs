-- Verify ggircs:function_load_report on pg

begin;

select pg_get_functiondef('ggircs_swrs_transform.load_report()'::regprocedure);

rollback;
