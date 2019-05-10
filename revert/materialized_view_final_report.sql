-- Revert ggircs:materialized_view_final_report from pg

begin;

drop materialized view ggircs_swrs.final_report;

commit;
