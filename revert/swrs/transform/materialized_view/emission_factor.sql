-- Revert ggircs:swrs/transform/materialized_view/emission_factor from pg

begin;

drop materialized view swrs_transform.emission_factor;

commit;
