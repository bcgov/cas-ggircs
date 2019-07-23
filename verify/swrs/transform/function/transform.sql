-- Verify ggircs:function_transform on pg

begin;

select pg_get_functiondef('swrs_transform.transform(text)'::regprocedure);

rollback;
