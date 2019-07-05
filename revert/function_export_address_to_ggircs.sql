-- Revert ggircs:function_export_address_to_ggircs from pg

begin;

drop function ggircs_swrs.export_address_to_ggircs;

commit;
