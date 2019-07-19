-- Revert ggircs:materialized_view_final_report from pg

begin;

drop materialized view ggircs_swrs_transform.final_report;

commit;
