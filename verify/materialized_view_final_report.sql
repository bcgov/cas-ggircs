-- Verify ggircs:materialized_view_final_report on pg

begin;

select * from ggircs_swrs.final_report where false;

rollback;
