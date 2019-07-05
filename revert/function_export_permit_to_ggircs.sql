-- Revert ggircs:function_export_permit_to_ggircs from pg

begin;

drop function ggircs_swrs.export_permit_to_ggircs;

commit;
