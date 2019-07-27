-- Verify ggircs:function_load_organisation on pg

begin;

select pg_get_functiondef('swrs_transform.load_organisation()'::regprocedure);

rollback;
