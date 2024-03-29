-- Deploy ggircs:swrs/extract/table/eccc_zip_file_001.sql to pg

begin;

alter table swrs_extract.eccc_zip_file add column xml_files_extracted boolean default false;
alter table swrs_extract.eccc_zip_file add column xml_files_extract_error_count integer default 0;
update swrs_extract.eccc_zip_file set xml_files_extracted = true; -- all xml files are extracted in existing zip files
alter table swrs_extract.eccc_zip_file add column attachments_extracted boolean default false;
alter table swrs_extract.eccc_zip_file add column attachments_extract_error_count integer default 0;

comment on column swrs_extract.eccc_zip_file.xml_files_extracted is 'true if all xml files contained in the zip file were inserted in the eccc_xml_file table';
comment on column swrs_extract.eccc_zip_file.attachments_extracted is 'true if all attachments contained in the zip file were inserted in the eccc_attachment table';
comment on column swrs_extract.eccc_zip_file.xml_files_extract_error_count is 'number of errors recorded while extracting xml files';
comment on column swrs_extract.eccc_zip_file.attachments_extract_error_count is 'number of errors recorded while extracting attachments';

commit;
