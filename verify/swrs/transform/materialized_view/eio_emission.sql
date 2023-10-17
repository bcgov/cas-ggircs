-- Verify ggircs:swrs/transform/materialized_view/eio_emission on pg

begin;

select * from swrs_transform.eio_emission where false;

rollback;
