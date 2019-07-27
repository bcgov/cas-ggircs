-- Deploy ggircs:swrs/transform/function/load_naics_category to pg
-- requires: swrs/transform/schema
-- requires: swrs/public/table/naics_category

BEGIN;

create or replace function swrs_transform.load_naics_category()
  returns void as
$function$
    begin
      insert into swrs_load.naics_category (naics_category) values ('Agriculture');
      insert into swrs_load.naics_category (naics_category) values ('Electricity and Heat Supply');
      insert into swrs_load.naics_category (naics_category) values ('Forest Products');
      insert into swrs_load.naics_category (naics_category) values ('Manufacturing');
      insert into swrs_load.naics_category (naics_category) values ('Mineral Products');
      insert into swrs_load.naics_category (naics_category) values ('Metals');
      insert into swrs_load.naics_category (naics_category) values ('Mining');
      insert into swrs_load.naics_category (naics_category) values ('Oil and Gas');
      insert into swrs_load.naics_category (naics_category) values ('Refineries');
      insert into swrs_load.naics_category (naics_category) values ('Construction');
      insert into swrs_load.naics_category (naics_category) values ('Pipelines');
      insert into swrs_load.naics_category (naics_category) values ('Waste');
      insert into swrs_load.naics_category (naics_category) values ('Other');

      insert into swrs_load.naics_category (naics_category) values ('Food Industry');
      insert into swrs_load.naics_category (naics_category) values ('Wood Products');
      insert into swrs_load.naics_category (naics_category) values ('Pulp and Paper');
      insert into swrs_load.naics_category (naics_category) values ('Chemicals');
      insert into swrs_load.naics_category (naics_category) values ('Other Consumer Products');
      insert into swrs_load.naics_category (naics_category) values ('Non-Metallic Materials');
      insert into swrs_load.naics_category (naics_category) values ('Metallic Materials');
      insert into swrs_load.naics_category (naics_category) values ('Coal Mining');
      insert into swrs_load.naics_category (naics_category) values ('Metal Mining');
      insert into swrs_load.naics_category (naics_category) values ('Oil and Gas Extraction');
      insert into swrs_load.naics_category (naics_category) values ('Oil Refining');
      insert into swrs_load.naics_category (naics_category) values ('Oil and Gas Transportation and Distribution');
      insert into swrs_load.naics_category (naics_category) values ('Waste Treatment');

      insert into swrs_load.naics_category (naics_category) values ('Cannabis');
      insert into swrs_load.naics_category (naics_category) values ('Liquefied Natural Gas Production');


    end
$function$ language plpgsql volatile;
COMMIT;
