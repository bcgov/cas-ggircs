-- Deploy ggircs:table_raw_report to pg
-- requires: schema_ggircs_private

begin;

create table ggircs_private.raw_report (
  id integer generated always as identity primary key,
  xml_file xml not null,
  imported_at timestamp with time zone not null default now()
);
comment on table  ggircs_private.raw_report is 'The raw xml files imported from existing legacy GHGR database in Oracle';
comment on column ggircs_private.raw_report.id is 'The internal primary key for the file';
comment on column ggircs_private.raw_report.xml_file is 'The raw xml file imported from GHGR';
comment on column ggircs_private.raw_report.imported_at is 'The timestamp noting when the file was imported';

--TODO: verify type and not null

commit;
