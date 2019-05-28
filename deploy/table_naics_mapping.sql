-- Deploy ggircs:table_naics_mapping to pg
-- requires: schema_ggircs_swrs

begin;

create table ggircs_swrs.naics_mapping (
  id integer generated always as identity primary key,
  naics_code integer,
  hhw_category varchar(1000),
  irc_category varchar(1000)
);

comment on table  ggircs_swrs.naics_mapping is 'The fuel mapping table that maps naics codes with hhw and irc categories';
comment on column ggircs_swrs.naics_mapping.id is 'The internal primary key for the mapping';
comment on column ggircs_swrs.naics_mapping.naics_code is 'The naics code';
comment on column ggircs_swrs.naics_mapping.naics_code is 'The higher level (hhw) category definition';
comment on column ggircs_swrs.naics_mapping.naics_code is 'The lower level irc category definition';

\copy ggircs_swrs.fuel_mapping(naics_code, hhw_category, irc_category) from './data/naics_mapping.csv' with (format csv);

commit;
