-- Verify ggircs:materialized_view_facility on pg

begin;

select * from swrs_transform.facility where false;

rollback;
