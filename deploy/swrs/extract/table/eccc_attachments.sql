-- Deploy ggircs:swrs/extract/table/eccc_attachments to pg
-- requires: schema_ggircs_swrs

begin;

create table swrs_extract.eccc_attachments (
  id integer generated always as identity primary key,
  imported_at timestamp with time zone not null default now(),
  attachment_file_name varchar(1000),
  attachment_file_md5_hash varchar(1000),
  zip_file_id integer references swrs_extract.eccc_zip_file(id)
);

comment on table  swrs_extract.eccc_attachments is 'The raw xml files imported from ECCC';
comment on column swrs_extract.eccc_attachments.id is 'The internal primary key for the file';
comment on column swrs_extract.eccc_attachments.imported_at is 'The timestamp noting when the file was imported to the GGIRCS database';
comment on column swrs_extract.eccc_attachments.attachment_file_name is 'The name of the attachment file';
comment on column swrs_extract.eccc_attachments.attachment_file_md5_hash is 'The unique md5 hash of the attachment file';
comment on column swrs_extract.eccc_attachments.zip_file_id is 'The id of the zip file the attachment file is in, if applicable';

create unique index attachment_file_md5_hash_uindex on swrs_extract.eccc_attachments(attachment_file_md5_hash);

commit;