-- Deploy ggircs:swrs/public/table/other_venting.sql to pg

begin;

create table swrs.other_venting (
  id integer primary key,
  eccc_xml_file_id integer,
  report_id integer references swrs.report(id),
  detail_tag varchar(1000),
  detail_value varchar(1000)
);

create index ggircs_other_venting_report_foreign_key on swrs.other_venting(report_id);

comment on table swrs.other_venting is 'The table containing the information on other venting sources';
comment on column swrs.other_venting.id is 'The primary key';
comment on column swrs.other_venting.eccc_xml_file_id is 'A foreign key reference to swrs_extract.eccc_xml_file';
comment on column swrs.other_venting.report_id is 'A foreign key reference to swrs.report';
comment on column swrs.other_venting.detail_tag is 'The name of the tag parsed by this materialized view. Describes the source of the "other venting"';
comment on column swrs.other_venting.detail_value is 'The value of the tag parsed by this materialized view. Describes how the "other venting" was vented';

commit;
