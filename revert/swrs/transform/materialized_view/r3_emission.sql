-- Revert ggircs:swrs/transform/materialized_view/r3_emission from pg

begin;

drop materialized view swrs_transform.r3_emission;

commit;
