-- Deploy ggircs:table_naics_mapping to pg
-- requires: schema_ggircs_swrs

begin;

create table ggircs_swrs.naics_mapping (
  id integer generated always as identity primary key,
  naics_code integer,
  hhw_category varchar(1000),
  irc_category varchar(1000)
);

comment on table  ggircs_swrs.naics_mapping is 'The fuel mapping table that maps naics codes with hhw and irc categories';
comment on column ggircs_swrs.naics_mapping.id is 'The internal primary key for the mapping';
comment on column ggircs_swrs.naics_mapping.naics_code is 'The naics code';
comment on column ggircs_swrs.naics_mapping.naics_code is 'The higher level (hhw) category definition';
comment on column ggircs_swrs.naics_mapping.naics_code is 'The lower level irc category definition';

INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (1, 111419, 'Agriculture', 'Food Industry');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (2, 221111, 'Electricity and Heat Supply', 'Electricity and Heat Supply');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (3, 221112, 'Electricity and Heat Supply', 'Electricity and Heat Supply');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (4, 221119, 'Electricity and Heat Supply', 'Electricity and Heat Supply');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (5, 221121, 'Electricity and Heat Supply', 'Electricity and Heat Supply');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (6, 221330, 'Electricity and Heat Supply', 'Electricity and Heat Supply');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (7, 321111, 'Forest Products', 'Wood Products');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (8, 321112, 'Forest Products', 'Wood Products');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (9, 321212, 'Forest Products', 'Wood Products');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (10, 322111, 'Forest Products', 'Pulp and Paper');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (11, 322112, 'Forest Products', 'Pulp and Paper');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (12, 322121, 'Forest Products', 'Pulp and Paper');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (13, 322122, 'Forest Products', 'Pulp and Paper');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (14, 321999, 'Forest Products', 'Pulp and Paper');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (15, 311119, 'Manufacturing', 'Food Industry');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (16, 311310, 'Manufacturing', 'Food Industry');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (17, 325181, 'Manufacturing', 'Chemicals');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (18, 325189, 'Manufacturing', 'Chemicals');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (19, 336390, 'Manufacturing', 'Other Consumer Products');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (20, 325120, 'Manufacturing', 'Chemicals');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (21, 327310, 'Mineral Products', 'Non-Metallic Materials ');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (22, 327410, 'Mineral Products', 'Non-Metallic Materials ');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (23, 327420, 'Mineral Products', 'Non-Metallic Materials ');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (24, 327990, 'Mineral Products', 'Non-Metallic Materials ');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (25, 331222, 'Metals', 'Metallic Materials');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (26, 331410, 'Metals', 'Metallic Materials');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (27, 331511, 'Metals', 'Metallic Materials');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (28, 331313, 'Metals', 'Metallic Materials');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (29, 331317, 'Metals', 'Metallic Materials');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (30, 212114, 'Mining', 'Coal Mining');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (31, 212220, 'Mining', 'Metal Mining');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (32, 212231, 'Mining', 'Metal Mining');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (33, 212232, 'Mining', 'Metal Mining');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (34, 212233, 'Mining', 'Metal Mining');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (35, 212299, 'Mining', 'Metal Mining');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (36, 211110, 'Oil and Gas', 'Oil and Gas Extraction');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (37, 721310, 'Oil and Gas', 'Oil and Gas Extraction');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (38, 493190, 'Oil and Gas', 'Oil and Gas Extraction');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (39, 324110, 'Refineries', 'Oil Refining');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (40, 237310, 'Construction', 'Construction');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (41, 237120, 'Construction', 'Construction');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (42, 486210, 'Pipelines', 'Oil and Gas Transportation and Distribution');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (43, 486110, 'Pipelines', 'Oil and Gas Transportation and Distribution');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (44, 412110, 'Pipelines', 'Oil and Gas Transportation and Distribution');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (45, 221210, 'Pipelines', 'Oil and Gas Transportation and Distribution');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (46, 562210, 'Waste', 'Waste Treatment');
INSERT INTO ggircs_swrs.naics_mapping (id, naics_code, hhw_category, irc_category) VALUES (47, 221320, 'Waste', 'Waste Treatment');

commit;
