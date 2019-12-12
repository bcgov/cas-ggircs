-- Deploy ggircs:swrs/extract/table/xml_schema_check to pg

begin;

create table swrs_extract.xml_schema_check (
  id integer generated always as identity primary key,
  historic_node varchar(1000)
);

commit;
