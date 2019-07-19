-- Revert ggircs:view_report_with_org from pg

begin;

drop view if exists ggircs_swrs_load.report_with_org;

commit;
