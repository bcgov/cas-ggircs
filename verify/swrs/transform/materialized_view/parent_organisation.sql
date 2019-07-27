-- Verify ggircs:materialized_view_parent_organisation on pg

begin;

select * from swrs_transform.parent_organisation where false;

rollback;
