-- Revert ggircs:function_export_additional_data_to_ggircs from pg

begin;

drop function ggircs_swrs.export_additional_data_to_ggircs;

commit;
