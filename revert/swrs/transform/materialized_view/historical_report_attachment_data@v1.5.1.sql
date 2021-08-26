-- Deploy ggircs:swrs/transform/materialized_view/historical_report_attachment_data to pg
-- requires: swrs/extract/table/eccc_xml_file

begin;
drop materialized view if exists swrs_transform.historical_report_attachment_data;
create materialized view swrs_transform.historical_report_attachment_data as (
  select
    row_number() over () as id,
    id as eccc_xml_file_id,
    attachment_data.*
  from swrs_extract.eccc_xml_file,
      xmltable(
        '//UploadedFileName[string-length(text()) > 0]/parent::FileDetails'
        passing xml_file
        columns
          process_name varchar(1000) path 'normalize-space(./ancestor::Process/@ProcessName)',
          sub_process_name varchar(1000) path 'normalize-space(./ancestor::SubProcess/@SubprocessName)',
          information_requirement varchar(1000) path 'normalize-space(./ancestor::SubProcess/@InformationRequirement)',
          file_number int path 'normalize-space(./File)',
          uploaded_file_name varchar(1000) path 'normalize-space(./UploadedFileName)',
          uploaded_by varchar(1000) path 'normalize-space(./UploadedBy)',
          uploaded_at timestamptz path 'normalize-space(./UploadedDate)'
      ) as attachment_data
) with no data;

create unique index historical_attachment_primary_key on swrs_transform.historical_report_attachment_data (eccc_xml_file_id);

comment on materialized view swrs_transform.historical_report_attachment_data is 'This materialized view contains data about the attachments related to a SWRS(single window reporting system) report, derived from eccc_xml_file table';
comment on column swrs_transform.historical_report_attachment_data.id is 'A generated index used for keying in the ggircs schema';
comment on column swrs_transform.historical_report_attachment_data.eccc_xml_file_id is 'The internal primary key for the file';
comment on column swrs_transform.historical_report_attachment_data.process_name is 'The process_name in this context describes the type of attachment (ie: Process Flow Diagram)';
comment on column swrs_transform.historical_report_attachment_data.sub_process_name is 'The sub_process_name in this context is a more in-depth description of this attachment';
comment on column swrs_transform.historical_report_attachment_data.information_requirement is 'Denotes whether or not this attachment is required. Can be one of [Optional, Required]';
comment on column swrs_transform.historical_report_attachment_data.file_number is 'The file_number corresponds to the type of attachment';
comment on column swrs_transform.historical_report_attachment_data.uploaded_file_name is 'The name of the attachment file that was uploaded';
comment on column swrs_transform.historical_report_attachment_data.uploaded_by is 'The name of the user who uploaded the attachment file';
comment on column swrs_transform.historical_report_attachment_data.uploaded_at is 'The date of upload';

commit;
