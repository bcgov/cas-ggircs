-- Verify ggircs:materialized_view_facility on pg

begin;

select * from ggircs_swrs.facility;

rollback;
