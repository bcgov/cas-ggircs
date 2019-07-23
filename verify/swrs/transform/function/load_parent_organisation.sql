-- Verify ggircs:function_load_parent_organisation on pg

begin;

select pg_get_functiondef('swrs_transform.load_parent_organisation()'::regprocedure);

rollback;
