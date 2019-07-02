-- Verify ggircs:function_export_activity_to_ggircs on pg

begin;

select pg_get_functiondef('ggircs_swrs.export_activity_to_ggircs()'::regprocedure);

rollback;
