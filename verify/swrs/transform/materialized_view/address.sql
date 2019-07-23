-- Verify ggircs:materialized_view_address on pg

begin;

select * from swrs_transform.address where false;

rollback;
