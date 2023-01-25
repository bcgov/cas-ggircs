-- Verify ggircs:swrs/transform/materialized_view/other_venting on pg

begin;

select * from swrs_transform.other_venting where false;

rollback;
