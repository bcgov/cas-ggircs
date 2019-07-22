-- Verify ggircs:view_report_with_org on pg

begin;

select * from ggircs.report_with_org where false;

rollback;
