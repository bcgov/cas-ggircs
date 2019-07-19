-- Verify ggircs:materialized_view_identifier on pg

begin;

select * from ggircs_swrs_transform.identifier where false;

rollback;
