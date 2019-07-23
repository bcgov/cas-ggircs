-- Verify ggircs:materialized_view_fuel on pg

begin;

select * from swrs_transform.fuel where false;

rollback;
