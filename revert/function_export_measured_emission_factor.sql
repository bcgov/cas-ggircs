-- Revert ggircs:function_export_measured_emission_factor from pg

begin;

drop function ggircs_swrs.export_measured_emission_factor_to_ggircs;

commit;
