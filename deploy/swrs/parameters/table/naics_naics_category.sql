-- Deploy ggircs:swrs/parameters/table/naics_naics_category to pg
-- requires: swrs/parameters/table/naics_category

begin;

create table ggircs_parameters.naics_naics_category (
  id integer generated always as identity primary key,
  naics_code_pattern varchar(1000),
  category_id integer references ggircs_parameters.naics_category(id)
);

comment on table  ggircs_parameters.naics_naics_category is 'The fuel mapping table that maps naics codes with hhw and irc categories';
comment on column ggircs_parameters.naics_naics_category.id is 'The internal primary key for the mapping';
comment on column ggircs_parameters.naics_naics_category.naics_code_pattern is 'The naics code pattern';
comment on column ggircs_parameters.naics_naics_category.category_id is 'The foreign key for the category';

insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (111419, 1);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (115110, 1);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (115210, 1);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (221111, 2);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (221112, 2);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (221119, 2);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (221121, 2);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (221330, 2);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (221122, 2);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (321111, 3);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (321112, 3);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (321212, 3);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (322111, 3);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (322112, 3);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (322121, 3);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (322122, 3);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (321999, 3);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (115310, 3);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (311119, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (311310, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (325181, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (325189, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (336390, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (325120, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (327310, 5);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (327410, 5);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (327420, 5);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (327990, 5);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (331222, 6);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (331410, 6);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (331511, 6);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (331313, 6);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (331317, 6);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (212114, 7);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (212220, 7);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (212231, 7);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (212232, 7);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (212233, 7);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (212299, 7);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (211110, 8);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (721310, 8);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (493190, 8);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (324110, 9);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (237310, 10);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (237120, 10);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (486210, 11);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (486110, 11);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (412110, 11);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (221210, 11);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (562210, 12);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (221320, 12);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (221310, 12);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (562910, 12);

-- IRC category_type
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (111419, 14);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (221111, 2);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (221112, 2);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (221119, 2);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (221121, 2);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (221330, 2);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (221122, 2);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (321111, 15);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (321112, 15);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (321212, 15);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (322111, 16);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (322112, 16);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (322121, 16);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (322122, 16);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (321999, 16);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (311119, 14);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (311310, 14);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (325181, 17);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (325189, 17);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (336390, 18);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (325120, 17);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (327310, 19);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (327410, 19);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (327420, 19);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (327990, 19);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (331222, 20);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (331410, 20);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (331511, 20);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (331313, 20);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (331317, 20);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (212114, 21);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (212220, 22);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (212231, 22);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (212232, 22);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (212233, 22);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (212299, 22);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (211110, 23);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (721310, 23);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (493190, 23);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (324110, 24);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (237310, 10);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (237120, 10);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (486210, 25);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (486110, 25);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (412110, 25);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (221210, 25);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (562210, 26);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (221320, 26);

insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (321216, 3);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (321216, 15);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (811199, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (811199, 18);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (493110, 8);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (211113, 8);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (211114, 8);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (493110, 23);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (211113, 23);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (211114, 23);

/** Mapping for incomplete NAICS codes **/

insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (111, 1);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (112, 1);

insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (321, 3);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (322, 3);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (113, 3);

insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (311, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (312, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (313, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (314, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (315, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (316, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (323, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (326, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (332, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (333, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (334, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (335, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (336, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (337, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (339, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (325, 4);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (327, 4);

insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (331, 6);

insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (212, 7);

insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (21114, 8);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (21311, 8);

insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (23, 10);

insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (4869, 11);

insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (721, 13);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (493, 13);
insert into ggircs_parameters.naics_naics_category (naics_code_pattern, category_id) values (41, 13);

commit;
