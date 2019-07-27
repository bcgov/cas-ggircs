-- Verify ggircs:materialized_view_permit on pg

begin;

select * from swrs_transform.permit where false;

rollback;
