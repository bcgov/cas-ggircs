-- Deploy ggircs:swrs/history/table/attachments to pg
-- requires: ggircs:swrs/history/schema

begin;

create table swrs_history.report_attachment
(
    id                        integer primary key,
    eccc_xml_file_id          integer references swrs_extract.eccc_xml_file,
    process_name              varchar(1000),
    sub_process_name          varchar(1000),
    information_requirement   varchar(1000),
    file_number               integer,
    uploaded_file_name        varchar(1000),
    uploaded_by               varchar(1000),
    uploaded_at               timestamptz
);

create index attachment_eccc_xml_file_fkey on swrs_history.report_attachment(eccc_xml_file_id);

comment on table swrs_history.report_attachment is 'The table housing all attachments for reports';
comment on column swrs_history.report_attachment.id is 'A generated index used for keying in the ggircs schema';
comment on column swrs_history.report_attachment.eccc_xml_file_id is 'The internal primary key for the file';
comment on column swrs_history.report_attachment.process_name is 'The process_name in this context describes the type of attachment (ie: Process Flow Diagram)';
comment on column swrs_history.report_attachment.sub_process_name is 'The sub_process_name in this context is a more in-depth description of this attachment';
comment on column swrs_history.report_attachment.information_requirement is 'Denotes whether or not this attachment is required. Can be one of [Optional, Required]';
comment on column swrs_history.report_attachment.file_number is 'The file_number corresponds to the type of attachment';
comment on column swrs_history.report_attachment.uploaded_file_name is 'The name of the attachment file that was uploaded';
comment on column swrs_history.report_attachment.uploaded_by is 'The name of the user who uploaded the attachment file';
comment on column swrs_history.report_attachment.uploaded_at is 'The date of upload';

commit;
