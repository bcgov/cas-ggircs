-- Verify ggircs:view_report_with_org on pg

begin;

select * from swrs.report_with_org where false;

rollback;
