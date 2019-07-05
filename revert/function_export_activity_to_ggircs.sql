-- Revert ggircs:function_export_activity_to_ggircs from pg

begin;

 drop function ggircs_swrs.export_activity_to_ggircs;

commit;
