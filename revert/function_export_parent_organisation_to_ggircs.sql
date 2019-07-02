-- Revert ggircs:function_export_parent_organisation_to_ggircs from pg

begin;

drop function ggircs_swrs.export_parent_organisation_to_ggircs;

commit;
