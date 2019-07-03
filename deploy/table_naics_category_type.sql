-- Deploy ggircs:table_naics_category_type to pg
-- requires: schema_ggircs

begin;

create table ggircs_swrs.naics_category_type (
  id integer generated always as identity primary key,
  naics_category_type varchar(1000),
  description varchar(1000)
);

comment on table  ggircs_swrs.naics_category is 'The fuel mapping table that maps naics codes with hhw and irc categories';
comment on column ggircs_swrs.naics_category.id is 'The internal primary key for the type mapping';
comment on column ggircs_swrs.naics_category.naics_category_type is 'The naics category type';
comment on column ggircs_swrs.naics_category.description is 'The description of the category type';

insert into ggircs_swrs.naics_category (naics_category, description) values ('hhw', $$Hilary's high level category type$$);
insert into ggircs_swrs.naics_category (naics_category, description) values ('irc', 'Industrial Reporting Category sector');

commit;
