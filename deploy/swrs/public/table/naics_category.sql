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

insert into swrs.naics_category (naics_category) values ('Agriculture');
insert into swrs.naics_category (naics_category) values ('Electricity and Heat Supply');
insert into swrs.naics_category (naics_category) values ('Forest Products');
insert into swrs.naics_category (naics_category) values ('Manufacturing');
insert into swrs.naics_category (naics_category) values ('Mineral Products');
insert into swrs.naics_category (naics_category) values ('Metals');
insert into swrs.naics_category (naics_category) values ('Mining');
insert into swrs.naics_category (naics_category) values ('Oil and Gas');
insert into swrs.naics_category (naics_category) values ('Refineries');
insert into swrs.naics_category (naics_category) values ('Construction');
insert into swrs.naics_category (naics_category) values ('Pipelines');
insert into swrs.naics_category (naics_category) values ('Waste');
insert into swrs.naics_category (naics_category) values ('Other');

insert into swrs.naics_category (naics_category) values ('Food Industry');
insert into swrs.naics_category (naics_category) values ('Wood Products');
insert into swrs.naics_category (naics_category) values ('Pulp and Paper');
insert into swrs.naics_category (naics_category) values ('Chemicals');
insert into swrs.naics_category (naics_category) values ('Other Consumer Products');
insert into swrs.naics_category (naics_category) values ('Non-Metallic Materials');
insert into swrs.naics_category (naics_category) values ('Metallic Materials');
insert into swrs.naics_category (naics_category) values ('Coal Mining');
insert into swrs.naics_category (naics_category) values ('Metal Mining');
insert into swrs.naics_category (naics_category) values ('Oil and Gas Extraction');
insert into swrs.naics_category (naics_category) values ('Oil Refining');
insert into swrs.naics_category (naics_category) values ('Oil and Gas Transportation and Distribution');
insert into swrs.naics_category (naics_category) values ('Waste Treatment');

insert into swrs.naics_category (naics_category) values ('Cannabis');
insert into swrs.naics_category (naics_category) values ('Liquefied Natural Gas Production');


commit;
