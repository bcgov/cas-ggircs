-- Verify ggircs:materialized_view_emission on pg

begin;

select * from ggircs_swrs_transform.emission where false;

rollback;
