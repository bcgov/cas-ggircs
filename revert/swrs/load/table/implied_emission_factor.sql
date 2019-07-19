-- Revert ggircs:table_implied_emission_factor from pg

begin;

drop table ggircs_swrs_load.implied_emission_factor;

commit;
