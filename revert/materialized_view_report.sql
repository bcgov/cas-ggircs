-- Revert ggircs:materialized_view_report from pg

begin;

drop materialized view ggircs_swrs.report;

commit;
