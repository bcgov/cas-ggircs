-- Deploy ggircs:table_ghgr_import to pg
-- requires: schema_ggircs_swrs

begin;

create table ggircs_swrs.ghgr_import (
  id integer generated always as identity primary key,
  xml_file xml not null,
  imported_at timestamp with time zone not null default now()
);
comment on table  ggircs_swrs.ghgr_import is 'The raw xml files imported from existing legacy GHGR database in Oracle';
comment on column ggircs_swrs.ghgr_import.id is 'The internal primary key for the file';
comment on column ggircs_swrs.ghgr_import.xml_file is 'The raw xml file imported from GHGR';
comment on column ggircs_swrs.ghgr_import.imported_at is 'The timestamp noting when the file was imported';

commit;
