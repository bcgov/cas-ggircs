-- Deploy ggircs:swrs/extract/table/eccc_xml_file__quarantined to pg

begin;

alter table swrs_extract.eccc_xml_file add column quarantined boolean default false;

comment on column swrs_extract.eccc_xml_file.quarantined is 'If an xml file is quarantined, it should not be transformed/loaded.';

commit;
