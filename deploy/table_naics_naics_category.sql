-- Deploy ggircs_swrs:table_naics_naics_category to pg
-- requires: schema_ggircs_swrs

begin;

create table ggircs_swrs.naics_naics_category (
  id integer generated always as identity primary key,
  naics_code_pattern varchar(1000),
  hhw_category_id integer,
  irc_category_id integer
);

comment on table  ggircs_swrs.naics_naics_category is 'The fuel mapping table that maps naics codes with hhw and irc categories';
comment on column ggircs_swrs.naics_naics_category.id is 'The internal primary key for the mapping';
comment on column ggircs_swrs.naics_naics_category.naics_code_pattern is 'The naics code pattern';
comment on column ggircs_swrs.naics_naics_category.hhw_category_id is 'The foreign key for the hhw category';
comment on column ggircs_swrs.naics_naics_category.irc_category_id is 'The foreign key for the irc category';

insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('111419%', 1, 15);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('115110%', 1, null);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('115210%', 1, null);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('221111%', 2, 15);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('221112%', 2, 15);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('221119%', 2, 15);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('221121%', 2, 15);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('221330%', 2, 15);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('221122%', 2, null);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('321111%', 3, 16);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('321112%', 3, 16);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('321212%', 3, 16);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('322111%', 3, 17);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('322112%', 3, 17);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('322121%', 3, 17);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('322122%', 3, 17);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('321999%', 3, 17);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('115310%', 3, null);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('311119%', 4, 14);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('311310%', 4, 14);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('325181%', 4, 18);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('325189%', 4, 18);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('336390%', 4, 19);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('325120%', 4, 18);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('327310%', 5, 20);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('327410%', 5, 20);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('327420%', 5, 20);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('327990%', 5, 20);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('331222%', 6, 21);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('331410%', 6, 21);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('331511%', 6, 21);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('331313%', 6, 21);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('331317%', 6, 21);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('212114%', 7, 22);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('212220%', 7, 23);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('212231%', 7, 23);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('212232%', 7, 23);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('212233%', 7, 23);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('212299%', 7, 23);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('211110%', 8, 24);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('721310%', 8, 24);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('493190%', 8, 24);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('324110%', 9, 25);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('237310%', 10, 26);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('237120%', 10, 26);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('486210%', 11, 27);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('486110%', 11, 27);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('412110%', 11, 27);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('221210%', 11, 27);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('562210%', 12, 28);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('221320%', 12, 28);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('221310%', 12, null);
insert into ggircs_swrs.naics_naics_category (naics_code_pattern, hhw_category_id, irc_category_id) values ('562910%', 12, null);