-- Revert ggircs:function_export_emission_to_ggircs from pg

begin;

drop function ggircs_swrs.export_emission_to_ggircs;

commit;
