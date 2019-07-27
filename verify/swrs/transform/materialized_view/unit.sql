-- Verify ggircs:materialized_view_unit on pg

begin;

select * from swrs_transform.unit where false;

rollback;
