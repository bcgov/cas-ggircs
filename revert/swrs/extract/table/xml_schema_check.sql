-- Revert ggircs:swrs/extract/table/xml_schema_check from pg

begin;

drop table swrs_extract.xml_schema_check;

commit;
