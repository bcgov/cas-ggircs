-- Deploy ggircs_swrs:table_naics_naics_category to pg
-- requires: schema_ggircs_swrs

begin;

create table ggircs_swrs.naics_naics_category (
  id integer generated always as identity primary key,
  naics_code integer,
  naics_code_pattern varchar(1000),
  hhw_category_id integer,
  irc_category_id integer
);

comment on table  ggircs_swrs.naics_naics_category is 'The fuel mapping table that maps naics codes with hhw and irc categories';
comment on column ggircs_swrs.naics_naics_category.id is 'The internal primary key for the mapping';
comment on column ggircs_swrs.naics_naics_category.naics_code is 'The naics code';
comment on column ggircs_swrs.naics_naics_category.naics_code_pattern is 'The naics code pattern';
comment on column ggircs_swrs.naics_naics_category.hhw_category_id is 'The foreign key for the hhw category';
comment on column ggircs_swrs.naics_naics_category.irc_category_id is 'The foreign key for the irc category';

insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (111419, null, 1, 15);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (115110, null, 1, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (115210, null, 1, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (221111, null, 2, 15);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (221112, null, 2, 15);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (221119, null, 2, 15);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (221121, null, 2, 15);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (221330, null, 2, 15);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (221122, null, 2, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (321111, null, 3, 16);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (321112, null, 3, 16);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (321212, null, 3, 16);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (322111, null, 3, 17);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (322112, null, 3, 17);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (322121, null, 3, 17);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (322122, null, 3, 17);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (321999, null, 3, 17);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (115310, null, 3, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (311119, null, 4, 14);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (311310, null, 4, 14);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (325181, null, 4, 18);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (325189, null, 4, 18);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (336390, null, 4, 19);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (325120, null, 4, 18);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (327310, null, 5, 20);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (327410, null, 5, 20);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (327420, null, 5, 20);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (327990, null, 5, 20);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (331222, null, 6, 21);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (331410, null, 6, 21);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (331511, null, 6, 21);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (331313, null, 6, 21);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (331317, null, 6, 21);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (212114, null, 7, 22);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (212220, null, 7, 23);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (212231, null, 7, 23);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (212232, null, 7, 23);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (212233, null, 7, 23);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (212299, null, 7, 23);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (211110, null, 8, 24);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (721310, null, 8, 24);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (493190, null, 8, 24);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (324110, null, 9, 25);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (237310, null, 10, 26);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (237120, null, 10, 26);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (486210, null, 11, 27);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (486110, null, 11, 27);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (412110, null, 11, 27);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (221210, null, 11, 27);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (562210, null, 12, 28);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (221320, null, 12, 28);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (221310, null, 12, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (562910, null, 12, null);

/** Mapping for incomplete NAICS codes **/

insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (111, '111%', 1, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (112, '112%', 1, null);

insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (321, '321%', 3, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (322, '322%', 3, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (113, '113%', 3, null);

insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (311, '311%', 4, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (312, '312%', 4, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (313, '313%', 4, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (314, '314%', 4, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (315, '315%', 4, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (316, '316%', 4, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (323, '323%', 4, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (326, '326%', 4, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (332, '332%', 4, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (333, '333%', 4, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (334, '334%', 4, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (335, '335%', 4, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (336, '336%', 4, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (337, '337%', 4, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (339, '339%', 4, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (325, '325%', 4, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (327, '327%', 4, null);

insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (331, '331%', 6, null);

insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (212, '212%', 7, null);

insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (21114, '21114%', 8, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (21311, '21311%', 8, null);

insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (23, '23%', 10, null);

insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (4869, '4869%', 11, null);

insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (721, '721%', 13, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (493, '493%', 13, null);
insert into ggircs_swrs.naics_naics_category (naics_code, naics_code_pattern, hhw_category_id, irc_category_id) values (41, '41%', 13, null);

commit;