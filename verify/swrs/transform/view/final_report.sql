-- Verify ggircs:materialized_view_final_report on pg

begin;

select * from ggircs_swrs_transform.final_report where false;

rollback;
