-- Revert ggircs:function_export_unit_to_ggircs from pg

begin;

drop function ggircs_swrs.export_unit_to_ggircs;

commit;
