-- Revert ggircs:table_measured_emission_factor from pg

begin;

drop table ggircs_swrs_load.measured_emission_factor;

commit;
