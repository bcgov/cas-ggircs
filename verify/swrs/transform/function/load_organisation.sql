-- Verify ggircs:function_load_organisation on pg

begin;

select pg_get_functiondef('ggircs_swrs_transform.load_organisation()'::regprocedure);

rollback;
