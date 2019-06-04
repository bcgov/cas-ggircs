-- Revert ggircs:table_measured_emission_factor from pg

begin;

drop table ggircs.measured_emission_factor;

commit;
