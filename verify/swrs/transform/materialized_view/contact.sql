-- Verify ggircs:materialized_view_contact on pg

begin;

select * from ggircs_swrs_transform.contact where false;

rollback;
