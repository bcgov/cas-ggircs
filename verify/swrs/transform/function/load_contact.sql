-- Verify ggircs:function_load_contact on pg

begin;

select pg_get_functiondef('ggircs_swrs_transform.load_contact()'::regprocedure);

rollback;
