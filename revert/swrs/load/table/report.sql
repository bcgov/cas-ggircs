-- Revert ggircs:table_report from pg

begin;

drop table ggircs_swrs_load.report;

commit;
