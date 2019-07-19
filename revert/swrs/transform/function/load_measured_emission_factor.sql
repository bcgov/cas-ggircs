-- Revert ggircs:function_load_measured_emission_factor from pg

begin;

drop function ggircs_swrs_transform.load_measured_emission_factor;

commit;
