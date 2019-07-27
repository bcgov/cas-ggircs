-- Deploy ggircs:table_naics_category to pg
-- requires: schema_ggircs_swrs

begin;

create table swrs.naics_category (
  id integer generated always as identity primary key,
  naics_category varchar(1000)
);

comment on table  swrs.naics_category is 'The fuel mapping table that maps naics codes with hhw and irc categories';
comment on column swrs.naics_category.id is 'The internal primary key for the mapping';
comment on column swrs.naics_category.naics_category is 'The naics category';
commit;
