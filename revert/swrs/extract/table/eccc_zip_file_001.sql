-- Revert ggircs:swrs/extract/table/eccc_zip_file_001.sql from pg

begin;

alter table swrs_extract.eccc_zip_file drop column xml_files_extracted;
alter table swrs_extract.eccc_zip_file drop column xml_files_extract_error_count;
alter table swrs_extract.eccc_zip_file drop column attachments_extracted;
alter table swrs_extract.eccc_zip_file drop column attachments_extract_error_count;

commit;
