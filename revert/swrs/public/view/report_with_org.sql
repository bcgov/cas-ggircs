-- Revert ggircs:view_report_with_org from pg

begin;

drop view if exists swrs.report_with_org;

commit;
