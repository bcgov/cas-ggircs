-- Revert ggircs:function_export_organisation_to_ggircs from pg

begin;

drop function ggircs_swrs.export_organisation_to_ggircs;

commit;
