-- Revert ggircs:function_export_mv_to_table from pg

BEGIN;

 drop function ggircs_swrs.export_mv_to_table;

COMMIT;
