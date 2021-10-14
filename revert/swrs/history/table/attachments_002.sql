-- Revert ggircs:swrs/history/table/attachments_002 from pg

begin;

alter table swrs_history.report_attachment drop column comment;

commit;
