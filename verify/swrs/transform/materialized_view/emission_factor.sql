-- Verify ggircs:swrs/transform/materialized_view/emission_factor on pg

begin;

select * from swrs_transform.emission_factor where false;

rollback;
