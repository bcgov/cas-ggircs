-- Verify ggircs:function_load_facility on pg

begin;

select pg_get_functiondef('swrs_transform.load_facility()'::regprocedure);

rollback;
