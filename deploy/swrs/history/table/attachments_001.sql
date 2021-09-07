-- Deploy ggircs:swrs/history/table/attachments_001.sql to pg

begin;

alter table swrs_history.report_attachment add column md5_hash varchar(1000);
alter table swrs_history.report_attachment add column file_path varchar(1000);
alter table swrs_history.report_attachment add column zip_file_name varchar(1000);

comment on column swrs_history.report_attachment.md5_hash is 'The md5 hash of the attachment';
comment on column swrs_history.report_attachment.file_path is 'The complete filepath to the attachment within zip_file_name';
comment on column swrs_history.report_attachment.zip_file_name is 'The name of the zip file containing the attachment';

commit;
