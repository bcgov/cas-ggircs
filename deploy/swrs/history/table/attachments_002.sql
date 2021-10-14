-- Deploy ggircs:swrs/history/table/attachments_002 to pg
-- requires: swrs/history/table/attachments

begin;

alter table swrs_history.report_attachment add column comment varchar(100000);

comment on column swrs_history.report_attachment.md5_hash is 'Comments relating to a specific attachment or the report itself';

commit;
