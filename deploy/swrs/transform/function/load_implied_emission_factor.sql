-- Deploy ggircs:swrs/transform/function/load_implied_emission_factor to pg
-- requires: swrs/transform/schema
-- requires: swrs/public/table/implied_emission_factor

begin;

drop function swrs_transform.load_implied_emission_factor;

commit;
