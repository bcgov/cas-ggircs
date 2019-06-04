-- Revert ggircs:table_final_report from pg

begin;

drop table ggircs.final_report;

commit;
