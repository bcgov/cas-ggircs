-- Verify ggircs:materialized_view_parent_organisation on pg

begin;

select * from ggircs_swrs_transform.parent_organisation where false;

rollback;
