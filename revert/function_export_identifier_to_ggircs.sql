-- Revert ggircs:function_export_identifier_to_ggircs from pg

begin;

drop function ggircs_swrs.export_identifier_to_ggircs;

commit;
