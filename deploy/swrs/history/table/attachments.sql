-- Deploy ggircs:swrs/history/table/attachments to pg
-- requires: ggircs:swrs/history/schema

begin;

create table swrs_history.report_attachment
(
    id                        integer primary key,
    report_id                 integer,
);

comment on table swrs_history.report_attachment is 'The table housing all attachments for reports';
comment on column swrs_history.report.report_id is 'Id of the report this attachment belongs to';

commit;
