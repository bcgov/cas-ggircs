-- Deploy ggircs:swrs/extract/table/eccc_attachment to pg
-- requires: schema_ggircs_swrs

begin;

create table swrs_extract.eccc_attachment (
  id integer generated always as identity primary key,
  imported_at timestamp with time zone not null default now(),
  attachment_file_path varchar(1000),
  attachment_file_md5_hash varchar(1000),
  zip_file_id integer references swrs_extract.eccc_zip_file(id) not null,
  attachment_uploaded_file_name varchar(1000),
  source_type_id integer,
  swrs_report_id integer
);

create index eccc_attachment_zip_file_idx on swrs_extract.eccc_attachment(zip_file_id);
create unique index eccc_attachment_zip_id_file_path_idx on swrs_extract.eccc_attachment(zip_file_id, attachment_file_path);

comment on table  swrs_extract.eccc_attachment is 'This table containes the list of files containd in the zip files imported from ECCC, excluding XML files (which can be found in the eccc_xml_file table) and other zip files that may be contained in the outer zip file.';
comment on column swrs_extract.eccc_attachment.id is 'The internal primary key for the file';
comment on column swrs_extract.eccc_attachment.imported_at is 'The timestamp noting when the file was imported to the GGIRCS database';
comment on column swrs_extract.eccc_attachment.attachment_file_path is 'The path of the file within the zip file';
comment on column swrs_extract.eccc_attachment.attachment_file_md5_hash is 'The md5 hash of the attachment file. Multiple attachments may have the same md5 hash as they are resubmitted with revisions of SWRS report';
comment on column swrs_extract.eccc_attachment.zip_file_id is 'The id of the zip file the attachment file is in';
comment on column swrs_extract.eccc_attachment.attachment_uploaded_file_name is 'The name of the file that was uploaded, inferred from the file path';
comment on column swrs_extract.eccc_attachment.source_type_id is 'The id of the source type of the attachment, inferred from the file path';
comment on column swrs_extract.eccc_attachment.swrs_report_id is 'The id of the SWRS report the attachment is associated with, inferred from the file path';

commit;
