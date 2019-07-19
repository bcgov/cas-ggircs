-- Verify ggircs:function_load_additional_data on pg

begin;

select pg_get_functiondef('ggircs_swrs_transform.load_additional_data()'::regprocedure);

rollback;
