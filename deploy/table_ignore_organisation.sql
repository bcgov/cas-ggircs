-- Deploy ggircs:table_ignore_organisation to pg
-- requires: schema_ggircs_swrs

begin;

create table ggircs_swrs.table_ignore_organisation (
  swrs_organisation_id numeric(1000, 0) not null primary key
);

insert into ggircs_swrs.table_ignore_organisation (swrs_organisation_id) 
values (5367)
     , (5401)
     , (6432)
     , (29004)
     , (29110)
     , (40627)
     , (42118)
     , (42261)
     , (42288)
     , (50606)
     , (100251)
     , (100306)
     , (111616)
     , (111619)
     , (111620)
     , (111911)
     , (112130)
     , (112291)
     , (112466)
     , (112649)
     , (112685)
     , (112706)
     , (113002)
     , (113119)
on conflict (swrs_organisation_id) do nothing;

comment on table ggircs_swrs.table_ignore_organisation is 'The list of organisations from the federal single window reporting system to ignore';
comment on column ggircs_swrs.table_ignore_organisation.swrs_organisation_id is 'The foreign key from swrs of the organisation that should be ignored';

commit;
