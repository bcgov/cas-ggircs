-- Deploy ggircs:table_naics_category to pg
-- requires: schema_ggircs_swrs

begin;

create table ggircs_swrs.naics_category (
  id integer generated always as identity primary key,
  naics_category varchar(1000),
  naics_category_type varchar(1000)
);

comment on table  ggircs_swrs.naics_category is 'The fuel mapping table that maps naics codes with hhw and irc categories';
comment on column ggircs_swrs.naics_category.id is 'The internal primary key for the mapping';
comment on column ggircs_swrs.naics_category.id is 'The foreign key for the category';

insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Agriculture', 'hhw');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Electricity and Heat Supply', 'hhw');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Forest Products', 'hhw');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Manufacturing', 'hhw');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Mineral Products', 'hhw');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Metals', 'hhw');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Mining', 'hhw');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Oil and Gas', 'hhw');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Refineries', 'hhw');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Construction', 'hhw');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Pipelines', 'hhw');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Waste', 'hhw');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Other', 'hhw');

insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Food Industry', 'irc');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Electricity and Heat Supply', 'irc');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Wood Products', 'irc');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Pulp and Paper', 'irc');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Chemicals', 'irc');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Other Consumer Products', 'irc');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Non-Metallic Materials', 'irc');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Metallic Materials', 'irc');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Coal Mining', 'irc');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Metal Mining', 'irc');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Oil and Gas Extraction', 'irc');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Oil Refining', 'irc');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Construction', 'irc');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Oil and Gas Transportation and Distribution', 'irc');
insert into ggircs_swrs.naics_category (naics_category, naics_category_type) values ('Waste Treatment', 'irc');

commit;
