-- Deploy ggircs:swrs/extract/table/eccc_attachments to pg
-- requires: schema_ggircs_swrs

begin;

create table swrs_extract.eccc_attachments (
  id integer generated always as identity primary key,
  imported_at timestamp with time zone not null default now(),
  attachment_file_path varchar(1000),
  attachment_file_md5_hash varchar(1000),
  zip_file_id integer references swrs_extract.eccc_zip_file(id) not null
);

comment on table  swrs_extract.eccc_attachments is 'This table containes the list of files containd in the zip files imported from ECCC, excluding XML files (which can be found in the eccc_xml_file table) and other zip files that may be contained in the outer zip file.';
comment on column swrs_extract.eccc_attachments.id is 'The internal primary key for the file';
comment on column swrs_extract.eccc_attachments.imported_at is 'The timestamp noting when the file was imported to the GGIRCS database';
comment on column swrs_extract.eccc_attachments.attachment_file_path is 'The path of the file within the zip file';
comment on column swrs_extract.eccc_attachments.attachment_file_md5_hash is 'The md5 hash of the attachment file';
comment on column swrs_extract.eccc_attachments.zip_file_id is 'The id of the zip file the attachment file is in';

commit;
