-- Deploy ggircs:table_eccc_xml_file to pg
-- requires: schema_ggircs_swrs

begin;

create table swrs_extract.eccc_xml_file (
  id integer generated always as identity primary key,
  xml_file xml not null,
  imported_at timestamp with time zone not null default now(),
  xml_file_name varchar(1000),
  xml_file_md5_hash varchar(1000),
  zip_file_id integer references swrs_extract.eccc_zip_file(id)
);

comment on table  swrs_extract.eccc_xml_file is 'The raw xml files imported from ECCC';
comment on column swrs_extract.eccc_xml_file.id is 'The internal primary key for the file';
comment on column swrs_extract.eccc_xml_file.xml_file is 'The raw xml file';
comment on column swrs_extract.eccc_xml_file.imported_at is 'The timestamp noting when the file was imported to the GGIRCS database';
comment on column swrs_extract.eccc_xml_file.xml_file_name is 'The name of the xml file';
comment on column swrs_extract.eccc_xml_file.xml_file_md5_hash is 'The unique md5 hash of the xml file';
comment on column swrs_extract.eccc_xml_file.zip_file_id is 'The id of the zip file the xml file is in, if applicable';

create unique index xml_file_md5_hash_uindex on swrs_extract.eccc_xml_file(xml_file_md5_hash);

commit;
