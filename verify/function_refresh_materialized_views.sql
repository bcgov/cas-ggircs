-- Verify ggircs:function_refresh_materialized_views on pg

begin;

select pg_get_functiondef('ggircs_swrs.refresh_materialized_views(text)'::regprocedure);

rollback;
