-- Verify ggircs:materialized_view_unit on pg

begin;

select * from ggircs_swrs.unit where false;

rollback;
