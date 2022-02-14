-- Deploy ggircs:swrs/parameters/table/carbon_tax_act_fuel_type to pg
-- requires: swrs/parameters/schema

begin;

create table ggircs_parameters.carbon_tax_act_fuel_type (
  id integer generated always as identity primary key,
  carbon_tax_fuel_type varchar(1000) not null
);

comment on table  ggircs_parameters.carbon_tax_act_fuel_type is 'Table contains the list of fuels as defined by the carbon tax act https://www.bclaws.gov.bc.ca/civix/document/id/complete/statreg/08040_01';
comment on column ggircs_parameters.carbon_tax_act_fuel_type.id is 'The internal primary key';
comment on column ggircs_parameters.carbon_tax_act_fuel_type.carbon_tax_fuel_type is 'Fuel type defined by the carbon tax act';

insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Aviation Fuel');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Gasoline');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Heavy Fuel Oil');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Jet Fuel');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Kerosene');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Light Fuel Oil');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Methanol');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Naphtha');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Butane');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Coke Oven Gas');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Ethane');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Propane');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Natural Gas');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Refinery Gas');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('High Heat Value Coal');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Low Heat Value Coal');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Coke');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Petroleum Coke');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Gas Liquids');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Pentanes Plus');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Peat');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Tires - Shredded');
insert into ggircs_parameters.carbon_tax_act_fuel_type(carbon_tax_fuel_type) values ('Tires - Whole');

commit;
