-- Deploy ggircs_swrs:table_naics_naics_category to pg
-- requires: schema_ggircs_swrs

begin;

create table ggircs.naics_naics_category (
  id integer generated always as identity primary key,
  naics_code_pattern varchar(1000),
  category_id integer,
  category_type_id integer
);

comment on table  ggircs.naics_naics_category is 'The fuel mapping table that maps naics codes with hhw and irc categories';
comment on column ggircs.naics_naics_category.id is 'The internal primary key for the mapping';
comment on column ggircs.naics_naics_category.naics_code_pattern is 'The naics code pattern';
comment on column ggircs.naics_naics_category.category_id is 'The foreign key for the category';
comment on column ggircs.naics_naics_category.category_type_id is 'The foreign key for the category type';

insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (111419, 1, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (115110, 1, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (115210, 1, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (221111, 2, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (221112, 2, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (221119, 2, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (221121, 2, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (221330, 2, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (221122, 2, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (321111, 3, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (321112, 3, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (321212, 3, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (322111, 3, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (322112, 3, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (322121, 3, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (322122, 3, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (321999, 3, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (115310, 3, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (311119, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (311310, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (325181, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (325189, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (336390, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (325120, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (327310, 5, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (327410, 5, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (327420, 5, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (327990, 5, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (331222, 6, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (331410, 6, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (331511, 6, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (331313, 6, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (331317, 6, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (212114, 7, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (212220, 7, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (212231, 7, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (212232, 7, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (212233, 7, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (212299, 7, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (211110, 8, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (721310, 8, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (493190, 8, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (324110, 9, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (237310, 10, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (237120, 10, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (486210, 11, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (486110, 11, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (412110, 11, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (221210, 11, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (562210, 12, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (221320, 12, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (221310, 12, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (562910, 12, 1);

-- IRC category_type
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (111419, 14, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (221111, 2, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (221112, 2, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (221119, 2, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (221121, 2, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (221330, 2, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (221122, 2, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (321111, 15, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (321112, 15, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (321212, 15, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (322111, 16, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (322112, 16, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (322121, 16, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (322122, 16, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (321999, 16, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (311119, 14, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (311310, 14, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (325181, 17, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (325189, 17, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (336390, 18, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (325120, 17, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (327310, 19, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (327410, 19, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (327420, 19, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (327990, 19, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (331222, 20, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (331410, 20, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (331511, 20 ,2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (331313, 20, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (331317, 20, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (212114, 21, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (212220, 22, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (212231, 22, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (212232, 22, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (212233, 22, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (212299, 22, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (211110, 23, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (721310, 23, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (493190, 23, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (324110, 24, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (237310, 10, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (237120, 10, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (486210, 25, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (486110, 25, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (412110, 25, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (221210, 25, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (562210, 26, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (221320, 26, 2);

insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (321216, 3, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (321216, 15, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (811199, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (811199, 18, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (493110, 8, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (211113, 8, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (211114, 8, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (493110, 23, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (211113, 23, 2);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (211114, 23, 2);

/** Mapping for incomplete NAICS codes **/

insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (111, 1, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (112, 1, 1);

insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (321, 3, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (322, 3, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (113, 3, 1);

insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (311, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (312, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (313, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (314, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (315, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (316, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (323, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (326, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (332, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (333, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (334, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (335, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (336, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (337, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (339, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (325, 4, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (327, 4, 1);

insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (331, 6, 1);

insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (212, 7, 1);

insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (21114, 8, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (21311, 8, 1);

insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (23, 10, 1);

insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (4869, 11, 1);

insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (721, 13, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (493, 13, 1);
insert into ggircs.naics_naics_category (naics_code_pattern, category_id, category_type_id) values (41, 13, 1);

commit;
