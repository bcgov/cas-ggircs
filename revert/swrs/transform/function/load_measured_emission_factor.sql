-- Revert ggircs:function_load_measured_emission_factor from pg

begin;

drop function swrs_transform.load_measured_emission_factor;

commit;
