-- Deploy ggircs:swrs/transform/function/load_carbon_tax_act_fuel_type to pg
-- requires: swrs/public/table/carbon_tax_act_fuel_type

begin;

create or replace function swrs_transform.load_carbon_tax_act_fuel_type()
  returns void as
$function$
    begin
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Aviation Fuel');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Gasoline');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Heavy Fuel Oil');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Jet Fuel');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Kerosene');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Light Fuel Oil');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Methanol');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Naphtha');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Butane');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Coke Oven Gas');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Ethane');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Propane');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Natural Gas');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Refinery Gas');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('High Heat Value Coal');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Low Heat Value Coal');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Coke');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Petroleum Coke');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Gas Liquids');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Pentanes Plus');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Peat');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Tires - Shredded');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Tires - Whole');
        insert into swrs_load.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Combustible Waste');
    end
$function$ language plpgsql volatile;

commit;
