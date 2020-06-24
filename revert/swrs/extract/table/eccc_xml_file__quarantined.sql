-- Revert ggircs:swrs/extract/table/eccc_xml_file__quarantined from pg

begin;

alter table swrs_extract.eccc_xml_file drop column quarantined;

commit;
