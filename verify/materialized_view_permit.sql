-- Verify ggircs:materialized_view_permit on pg

begin;

select * from ggircs_swrs.permit where false;

rollback;
