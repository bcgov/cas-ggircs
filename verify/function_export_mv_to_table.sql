-- Verify ggircs:function_export_mv_to_table on pg

BEGIN;

select pg_get_functiondef('ggircs_swrs.export_mv_to_table()'::regprocedure);

ROLLBACK;
