-- Verify ggircs:materialized_view_identifier on pg

begin;

select * from ggircs_swrs.identifier where false;

rollback;
