-- Revert ggircs:table_measured_emission_factor from pg

begin;

drop table swrs.measured_emission_factor;

commit;
