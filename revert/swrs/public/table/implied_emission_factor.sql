-- Revert ggircs:table_implied_emission_factor from pg

begin;

drop table ggircs.implied_emission_factor;

commit;
