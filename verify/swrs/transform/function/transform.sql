-- Verify ggircs:function_transform on pg

begin;

select pg_get_functiondef('ggircs_swrs_transform.transform(text)'::regprocedure);

rollback;
