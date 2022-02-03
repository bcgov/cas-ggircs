-- Deploy ggircs:swrs/utility/table/carbon_tax_act_fuel_type to pg
-- requires: swrs/utility/schema

begin;

create table swrs_utility.carbon_tax_act_fuel_type (
  id integer generated always as identity primary key,
  carbon_tax_fuel_type varchar(1000) not null
);

comment on table  swrs_utility.carbon_tax_act_fuel_type is 'Table contains the list of fuels as defined by the carbon tax act https://www.bclaws.gov.bc.ca/civix/document/id/complete/statreg/08040_01';
comment on column swrs_utility.carbon_tax_act_fuel_type.id is 'The internal primary key';
comment on column swrs_utility.carbon_tax_act_fuel_type.carbon_tax_fuel_type is 'Fuel type defined by the carbon tax act';

insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Aviation Fuel');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Gasoline');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Heavy Fuel Oil');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Jet Fuel');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Kerosene');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Light Fuel Oil');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Methanol');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Naphtha');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Butane');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Coke Oven Gas');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Ethane');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Propane');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Natural Gas');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Refinery Gas');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('High Heat Value Coal');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Low Heat Value Coal');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Coke');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Petroleum Coke');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Gas Liquids');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Pentanes Plus');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Peat');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Tires - Shredded');
insert into swrs_utility.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Tires - Whole');

commit;
