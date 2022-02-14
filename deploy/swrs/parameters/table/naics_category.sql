-- Deploy ggircs:swrs/parameters/table/naics_category to pg
-- requires: swrs/parameters/schema

begin;

create table ggircs_parameters.naics_category (
  id integer generated always as identity primary key,
  naics_category varchar(1000)
);

comment on table  ggircs_parameters.naics_category is 'The fuel mapping table that maps naics codes with hhw and irc categories';
comment on column ggircs_parameters.naics_category.id is 'The internal primary key for the mapping';
comment on column ggircs_parameters.naics_category.naics_category is 'The naics category';

insert into ggircs_parameters.naics_category (naics_category) values ('Agriculture');
insert into ggircs_parameters.naics_category (naics_category) values ('Electricity and Heat Supply');
insert into ggircs_parameters.naics_category (naics_category) values ('Forest Products');
insert into ggircs_parameters.naics_category (naics_category) values ('Manufacturing');
insert into ggircs_parameters.naics_category (naics_category) values ('Mineral Products');
insert into ggircs_parameters.naics_category (naics_category) values ('Metals');
insert into ggircs_parameters.naics_category (naics_category) values ('Mining');
insert into ggircs_parameters.naics_category (naics_category) values ('Oil and Gas');
insert into ggircs_parameters.naics_category (naics_category) values ('Refineries');
insert into ggircs_parameters.naics_category (naics_category) values ('Construction');
insert into ggircs_parameters.naics_category (naics_category) values ('Pipelines');
insert into ggircs_parameters.naics_category (naics_category) values ('Waste');
insert into ggircs_parameters.naics_category (naics_category) values ('Other');

insert into ggircs_parameters.naics_category (naics_category) values ('Food Industry');
insert into ggircs_parameters.naics_category (naics_category) values ('Wood Products');
insert into ggircs_parameters.naics_category (naics_category) values ('Pulp and Paper');
insert into ggircs_parameters.naics_category (naics_category) values ('Chemicals');
insert into ggircs_parameters.naics_category (naics_category) values ('Other Consumer Products');
insert into ggircs_parameters.naics_category (naics_category) values ('Non-Metallic Materials');
insert into ggircs_parameters.naics_category (naics_category) values ('Metallic Materials');
insert into ggircs_parameters.naics_category (naics_category) values ('Coal Mining');
insert into ggircs_parameters.naics_category (naics_category) values ('Metal Mining');
insert into ggircs_parameters.naics_category (naics_category) values ('Oil and Gas Extraction');
insert into ggircs_parameters.naics_category (naics_category) values ('Oil Refining');
insert into ggircs_parameters.naics_category (naics_category) values ('Oil and Gas Transportation and Distribution');
insert into ggircs_parameters.naics_category (naics_category) values ('Waste Treatment');

insert into ggircs_parameters.naics_category (naics_category) values ('Cannabis');
insert into ggircs_parameters.naics_category (naics_category) values ('Liquefied Natural Gas Production');


commit;
