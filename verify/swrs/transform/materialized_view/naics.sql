-- Verify ggircs:materialized_view_naics on pg

begin;

select * from swrs_transform.naics where false;

rollback;
