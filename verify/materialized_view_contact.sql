-- Verify ggircs:materialized_view_contact on pg

begin;

select * from ggircs_swrs.contact where false;

rollback;
