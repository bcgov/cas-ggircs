-- Revert ggircs:table_report_schema_diff from pg

begin;

drop table swrs_extract.report_schema_diff;

commit;
