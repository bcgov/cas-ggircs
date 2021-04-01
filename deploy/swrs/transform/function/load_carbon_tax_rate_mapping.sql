-- Deploy ggircs:swrs/transform/function/load_carbon_tax_rate_mapping to pg
-- requires: swrs/transform/schema
-- requires: swrs/public/table/carbon_tax_rate_mapping

BEGIN;

create or replace function swrs_transform.load_carbon_tax_rate_mapping()
  returns void as
$function$
    begin
        insert into swrs_load.carbon_tax_rate_mapping(rate_start_date, rate_end_date, carbon_tax_rate) values ('0001-01-01', '2017-03-31', 30);
        insert into swrs_load.carbon_tax_rate_mapping(rate_start_date, rate_end_date, carbon_tax_rate) values ('2017-04-01', '2018-03-31', 30);
        insert into swrs_load.carbon_tax_rate_mapping(rate_start_date, rate_end_date, carbon_tax_rate) values ('2018-04-01', '2019-03-31', 35);
        insert into swrs_load.carbon_tax_rate_mapping(rate_start_date, rate_end_date, carbon_tax_rate) values ('2019-04-01', '2020-03-31', 40);
        insert into swrs_load.carbon_tax_rate_mapping(rate_start_date, rate_end_date, carbon_tax_rate) values ('2020-04-01', '2021-03-31', 40);
        insert into swrs_load.carbon_tax_rate_mapping(rate_start_date, rate_end_date, carbon_tax_rate) values ('2021-04-01', '2022-03-31', 45);
        insert into swrs_load.carbon_tax_rate_mapping(rate_start_date, rate_end_date, carbon_tax_rate) values ('2022-04-01', '9999-03-31', 50);
    end
$function$ language plpgsql volatile;

COMMIT;
