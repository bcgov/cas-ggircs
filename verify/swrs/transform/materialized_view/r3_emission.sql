-- Verify ggircs:swrs/transform/materialized_view/r3_emission on pg

begin;

select * from swrs_transform.r3_emission where false;

rollback;
