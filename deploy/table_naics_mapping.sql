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

INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (111419, 'Agriculture', 'Food Industry');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (221111, 'Electricity and Heat Supply', 'Electricity and Heat Supply');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (221112, 'Electricity and Heat Supply', 'Electricity and Heat Supply');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (221119, 'Electricity and Heat Supply', 'Electricity and Heat Supply');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (221121, 'Electricity and Heat Supply', 'Electricity and Heat Supply');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (221330, 'Electricity and Heat Supply', 'Electricity and Heat Supply');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (321111, 'Forest Products', 'Wood Products');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (321112, 'Forest Products', 'Wood Products');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (321212, 'Forest Products', 'Wood Products');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (322111, 'Forest Products', 'Pulp and Paper');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (322112, 'Forest Products', 'Pulp and Paper');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (322121, 'Forest Products', 'Pulp and Paper');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (322122, 'Forest Products', 'Pulp and Paper');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (321999, 'Forest Products', 'Pulp and Paper');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (311119, 'Manufacturing', 'Food Industry');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (311310, 'Manufacturing', 'Food Industry');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (325181, 'Manufacturing', 'Chemicals');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (325189, 'Manufacturing', 'Chemicals');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (336390, 'Manufacturing', 'Other Consumer Products');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (325120, 'Manufacturing', 'Chemicals');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (327310, 'Mineral Products', 'Non-Metallic Materials ');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (327410, 'Mineral Products', 'Non-Metallic Materials ');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (327420, 'Mineral Products', 'Non-Metallic Materials ');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (327990, 'Mineral Products', 'Non-Metallic Materials ');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (331222, 'Metals', 'Metallic Materials');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (331410, 'Metals', 'Metallic Materials');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (331511, 'Metals', 'Metallic Materials');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (331313, 'Metals', 'Metallic Materials');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (331317, 'Metals', 'Metallic Materials');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (212114, 'Mining', 'Coal Mining');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (212220, 'Mining', 'Metal Mining');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (212231, 'Mining', 'Metal Mining');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (212232, 'Mining', 'Metal Mining');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (212233, 'Mining', 'Metal Mining');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (212299, 'Mining', 'Metal Mining');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (211110, 'Oil and Gas', 'Oil and Gas Extraction');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (721310, 'Oil and Gas', 'Oil and Gas Extraction');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (493190, 'Oil and Gas', 'Oil and Gas Extraction');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (324110, 'Refineries', 'Oil Refining');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (237310, 'Construction', 'Construction');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (237120, 'Construction', 'Construction');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (486210, 'Pipelines', 'Oil and Gas Transportation and Distribution');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (486110, 'Pipelines', 'Oil and Gas Transportation and Distribution');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (412110, 'Pipelines', 'Oil and Gas Transportation and Distribution');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (221210, 'Pipelines', 'Oil and Gas Transportation and Distribution');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (562210, 'Waste', 'Waste Treatment');
INSERT INTO ggircs_swrs.naics_mapping (naics_code, hhw_category, irc_category) VALUES (221320, 'Waste', 'Waste Treatment');

commit;
