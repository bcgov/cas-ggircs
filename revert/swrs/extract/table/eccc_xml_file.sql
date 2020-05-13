-- Revert ggircs:table_eccc_xml_file from pg

begin;

drop table swrs_extract.eccc_xml_file;

commit;
