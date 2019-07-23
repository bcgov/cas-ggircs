-- Verify ggircs:materialized_view_additional_data on pg

begin;

select * from swrs_transform.additional_data where false;

rollback;
