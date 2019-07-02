-- Revert ggircs:function_export_contact_to_ggircs from pg

begin;

drop function ggircs_swrs.export_contact_to_ggircs;

commit;
