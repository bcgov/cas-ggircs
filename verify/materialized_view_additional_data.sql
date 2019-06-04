-- Verify ggircs:materialized_view_additional_data on pg

begin;

select * from ggircs_swrs.additional_data where false;

rollback;
