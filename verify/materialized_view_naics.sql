-- Verify ggircs:materialized_view_naics on pg

begin;

select * from ggircs_swrs.naics where false;

rollback;
