-- Revert ggircs:swrs/transform/function/load_implied_emission_factor from pg

begin;

drop function swrs_transform.load_implied_emission_factor;

commit;
