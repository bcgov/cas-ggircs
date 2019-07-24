-- Deploy swrs_transform:table_naics_naics_category to pg
-- requires: schema_ggircs_swrs

begin;

create table swrs.naics_naics_category (
  id integer generated always as identity primary key,
  naics_code_pattern varchar(1000),
  category_id integer,
  category_type_id integer
);

comment on table  swrs.naics_naics_category is 'The fuel mapping table that maps naics codes with hhw and irc categories';
comment on column swrs.naics_naics_category.id is 'The internal primary key for the mapping';
comment on column swrs.naics_naics_category.naics_code_pattern is 'The naics code pattern';
comment on column swrs.naics_naics_category.category_id is 'The foreign key for the category';
comment on column swrs.naics_naics_category.category_type_id is 'The foreign key for the category type';

commit;
