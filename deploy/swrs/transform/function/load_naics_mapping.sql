-- Deploy ggircs:swrs/transform/function/load_naics_mapping to pg
-- requires: swrs/transform/schema
-- requires: swrs/public/table/naics_mapping

BEGIN;

create or replace function swrs_transform.load_naics_mapping()
  returns void as
$function$
    begin
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (111419, 'Agriculture', 'Food Industry');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (115110, 'Agriculture', null);
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (115210, 'Agriculture', null);
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (221111, 'Electricity and Heat Supply', 'Electricity and Heat Supply');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (221112, 'Electricity and Heat Supply', 'Electricity and Heat Supply');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (221119, 'Electricity and Heat Supply', 'Electricity and Heat Supply');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (221121, 'Electricity and Heat Supply', 'Electricity and Heat Supply');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (221330, 'Electricity and Heat Supply', 'Electricity and Heat Supply');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (221122, 'Electricity and Heat Supply', null);
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (321111, 'Forest Products', 'Wood Products');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (321112, 'Forest Products', 'Wood Products');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (321212, 'Forest Products', 'Wood Products');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (322111, 'Forest Products', 'Pulp and Paper');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (322112, 'Forest Products', 'Pulp and Paper');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (322121, 'Forest Products', 'Pulp and Paper');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (322122, 'Forest Products', 'Pulp and Paper');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (321999, 'Forest Products', 'Pulp and Paper');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (115310, 'Forest Products', null);
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (311119, 'Manufacturing', 'Food Industry');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (311310, 'Manufacturing', 'Food Industry');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (325181, 'Manufacturing', 'Chemicals');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (325189, 'Manufacturing', 'Chemicals');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (336390, 'Manufacturing', 'Other Consumer Products');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (325120, 'Manufacturing', 'Chemicals');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (327310, 'Mineral Products', 'Non-Metallic Materials ');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (327410, 'Mineral Products', 'Non-Metallic Materials ');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (327420, 'Mineral Products', 'Non-Metallic Materials ');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (327990, 'Mineral Products', 'Non-Metallic Materials ');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (331222, 'Metals', 'Metallic Materials');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (331410, 'Metals', 'Metallic Materials');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (331511, 'Metals', 'Metallic Materials');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (331313, 'Metals', 'Metallic Materials');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (331317, 'Metals', 'Metallic Materials');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (212114, 'Mining', 'Coal Mining');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (212220, 'Mining', 'Metal Mining');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (212231, 'Mining', 'Metal Mining');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (212232, 'Mining', 'Metal Mining');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (212233, 'Mining', 'Metal Mining');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (212299, 'Mining', 'Metal Mining');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (211110, 'Oil and Gas', 'Oil and Gas Extraction');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (721310, 'Oil and Gas', 'Oil and Gas Extraction');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (493190, 'Oil and Gas', 'Oil and Gas Extraction');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (324110, 'Refineries', 'Oil Refining');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (237310, 'Construction', 'Construction');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (237120, 'Construction', 'Construction');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (486210, 'Pipelines', 'Oil and Gas Transportation and Distribution');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (486110, 'Pipelines', 'Oil and Gas Transportation and Distribution');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (412110, 'Pipelines', 'Oil and Gas Transportation and Distribution');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (221210, 'Pipelines', 'Oil and Gas Transportation and Distribution');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (562210, 'Waste', 'Waste Treatment');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (221320, 'Waste', 'Waste Treatment');
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (221310, 'Waste', null);
      insert into swrs_load.naics_mapping (naics_code, hhw_category, irc_category) values (562910, 'Waste', null);


      /** Mapping for incomplete NAICS codes (id overridden to start at 9000 for all partials) **/

      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9000, 111, 'Agriculture', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9001, 112, 'Agriculture', null);

      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9002, 321, 'Forest Products', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9003, 322, 'Forest Products', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9004, 113, 'Forest Products', null);

      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9005, 311, 'Manufacturing', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9006, 312, 'Manufacturing', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9007, 313, 'Manufacturing', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9008, 314, 'Manufacturing', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9009, 315, 'Manufacturing', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9010, 316, 'Manufacturing', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9011, 323, 'Manufacturing', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9012, 326, 'Manufacturing', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9013, 332, 'Manufacturing', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9014, 333, 'Manufacturing', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9015, 334, 'Manufacturing', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9016, 335, 'Manufacturing', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9017, 336, 'Manufacturing', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9018, 337, 'Manufacturing', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9019, 339, 'Manufacturing', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9020, 325, 'Manufacturing', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9021, 327, 'Manufacturing', null);

      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9022, 331, 'Metals', null);

      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9023, 212, 'Mining', null);

      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9024, 21114, 'Oil and Gas', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9025, 21311, 'Oil and Gas', null);

      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9026, 23, 'Construction', null);

      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9027, 4869, 'Pipelines', null);

      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9028, 721, 'Other', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9029, 493, 'Other', null);
      insert into swrs_load.naics_mapping (id, naics_code, hhw_category, irc_category) overriding system value values (9030, 41, 'Other', null);

    end
$function$ language plpgsql volatile;
COMMIT;
