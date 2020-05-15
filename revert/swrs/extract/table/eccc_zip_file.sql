-- Revert ggircs:table_eccc_zip_file from pg

begin;

drop table swrs_extract.eccc_zip_file;

commit;
