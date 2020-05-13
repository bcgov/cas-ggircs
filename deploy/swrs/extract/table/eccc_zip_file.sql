-- Deploy ggircs:swrs/extract/table/eccc_zip_file to pg
-- requires: schema_ggircs_swrs

begin;

create table swrs_extract.eccc_zip_file (
  id integer generated always as identity primary key,
  zip_file_name varchar(1000),
  zip_file_md5_hash varchar(1000),
  imported_at timestamp with time zone not null default now()
);
comment on table  swrs_extract.eccc_zip_file is 'The table listing the zip files imported from ECCC';
comment on column swrs_extract.eccc_zip_file.id is 'The internal primary key for the file';
comment on column swrs_extract.eccc_zip_file.zip_file_name is 'The name of the zip file';
comment on column swrs_extract.eccc_zip_file.zip_file_md5_hash is 'The unique md5 hash of the file';
comment on column swrs_extract.eccc_zip_file.imported_at is 'The timestamp noting when the file was imported';

create unique index zip_file_md5_hash_uindex on swrs_extract.eccc_zip_file(zip_file_md5_hash);

commit;
