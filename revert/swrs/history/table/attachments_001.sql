-- Revert ggircs:swrs/history/table/attachments_001.sql from pg

begin;

alter table swrs_history.report_attachment drop column md5_hash;
alter table swrs_history.report_attachment drop column file_path;
alter table swrs_history.report_attachment drop column zip_file_name;

commit;
