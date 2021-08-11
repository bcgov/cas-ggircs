-- Revert ggircs:swrs/history/table/attachments from pg

begin;

drop table swrs_history.report_attachment;

commit;
