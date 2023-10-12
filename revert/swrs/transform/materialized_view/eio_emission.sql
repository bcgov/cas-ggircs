-- Revert ggircs:swrs/transform/materialized_view/eio_emission from pg

begin;

drop materialized view swrs_transform.eio_emission;

commit;
