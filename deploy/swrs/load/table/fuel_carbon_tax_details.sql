-- Deploy ggircs:table_fuel_carbon_tax_details to pg
-- requires: schema_ggircs_swrs

-- Deploy ggircs:table_fuel_carbon_tax_details to pg
-- requires: schema_ggircs_swrs

begin;

create table ggircs_swrs_load.fuel_carbon_tax_details (
  id integer generated always as identity primary key,
  normalized_fuel_type varchar(1000),
  state varchar(1000),
  carbon_taxed boolean,
  cta_mapping varchar(1000),
  cta_rate_units varchar(1000),
  unit_conversion_factor integer

);

comment on table  ggircs_swrs_load.fuel_carbon_tax_details is 'The fuel mapping table that maps fuel type with carbon tax rates';
comment on column ggircs_swrs_load.fuel_carbon_tax_details.id is 'The internal primary key for the mapping';
comment on column ggircs_swrs_load.fuel_carbon_tax_details.normalized_fuel_type is 'The type of fuel (Normalized)';
comment on column ggircs_swrs_load.fuel_carbon_tax_details.state is 'The state of the fuel (gas, liquid, solid)';
comment on column ggircs_swrs_load.fuel_carbon_tax_details.carbon_taxed is 'Is the fuel carbon taxed';
comment on column ggircs_swrs_load.fuel_carbon_tax_details.cta_mapping is 'Generalized high-level fuel type';
comment on column ggircs_swrs_load.fuel_carbon_tax_details.cta_rate_units is 'The units of measure';
comment on column ggircs_swrs_load.fuel_carbon_tax_details.unit_conversion_factor is 'The conversion factor for cta units to reported units';

insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Acetylene (Sm^3)','(Gas)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Agricultural Byproducts (bone dry tonnes)','(Solid)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Anthracite Coal (tonnes)','(Solid)','t','High Heat Value Coal','$/tonne',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Asphalt & Road Oil (kilolitres)','(Liquid)','t','Heavy Fuel Oil','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Aviation Gasoline (kilolitres)','(Liquid)','t','Aviation Fuel','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Aviation Turbo Fuel (kilolitres)','(Liquid)','t','Aviation Fuel','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Biodiesel (100%) (kilolitres)','(Liquid)','t','Light Fuel Oil','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Biogas (captured methane) (Sm^3)','(Gas)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Bituminous Coal (tonnes)','(Solid)','t','High Heat Value Coal','$/tonne',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Bone char - organics (tonnes)','(Solid)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Butane (kilolitres)','(Liquid)','t','Butane','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Butylene (kilolitres)','(Liquid)','f','n/a','n/a',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('C/D Waste - Plastic (tonnes)','(Solid)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('C/D Waste - Wood (tonnes)','(Solid)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Cloth (tonnes)','(Solid)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('CNCGs (Sm^3)','(Gas)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Coal Coke (tonnes)','(Solid)','t','Coke','$/tonne',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Coal/PetCoke  blend (tonnes)','(Solid)','t','Coke','$/tonne',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Coke Oven Gas (Sm^3)','(Gas)','t','Coke Oven Gas','$/m3',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Combustible Tall Oil (kilolitres)','(Liquid)','f','n/a','n/a',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Crude Oil (kilolitres)','(Liquid)','f','n/a','n/a',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Crude Sulfate Turpentine (CST) (kilolitres)','(Liquid)','f','n/a','n/a',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Crude Tall Oil (CTO) (kilolitres)','(Liquid)','f','n/a','n/a',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Diesel (kilolitres)','(Liquid)','t','Light Fuel Oil','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Digester Gas (Sm^3)','(Gas)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Distilate Fuel Oil No.1 (kilolitres)','(Liquid)','t','Light Fuel Oil','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Distilate Fuel Oil No.2 (kilolitres)','(Liquid)','t','Light Fuel Oil','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Distilate Fuel Oil No.4 (kilolitres)','(Liquid)','t','Light Fuel Oil','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('DNCGs (Sm^3)','(Gas)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Ethane (kilolitres)','(Liquid)','t','Ethane','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Ethanol (100%) (kilolitres)','(Liquid)','f','n/a','n/a',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Ethylene (kilolitres)','(Liquid)','f','n/a','n/a',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('E-Waste (tonnes)','(Solid)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Explosives (tonnes)','(Solid)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Field gas or process vent gas  (Sm^3)','(Gas)','t','Natural Gas','$/m3',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Field Gas (Sm^3)','(Gas)','t','Natural Gas','$/m3',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Foreign Bituminous Coal (tonnes)','(Solid)','t','High Heat Value Coal','$/tonne',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Isobutane (kilolitres)','(Liquid)','t','Butane','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Isobutylene (kilolitres)','(Liquid)','f','n/a','n/a',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Kerosene (kilolitres)','(Liquid)','t','Kerosene','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Kerosene-type Jet Fuel (kilolitres)','(Liquid)','t','Jet Fuel','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Landfill Gas (Sm^3)','(Gas)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Light Fuel Oil (kilolitres)','(Liquid)','t','Light Fuel Oil','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Lignite (tonnes)','(Solid)','t','Low Heat Value Coal','$/tonne',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Liquified Petroleum Gases (LPG) (kilolitres)','(Liquid)','t','Gas Liquids','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Lubricants (kilolitres)','(Liquid)','f','n/a','n/a',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Motor Gasoline (kilolitres)','(Liquid)','t','Gasoline','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Motor Gasoline - Off-Road (kilolitres)','(Liquid)','t','Gasoline','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Municipal Solid Waste - biomass component (bone dry tonnes)','(Solid)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Municipal Solid Waste - non-biomass component (tonnes)','(Solid)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Naphtha (kilolitres)','(Liquid)','t','Naphtha','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Natural Gasoline (kilolitres)','(Liquid)','t','Gasoline','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Natural Gas (Sm^3)','(Gas)','t','Natural Gas','$/m3',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Nitrous Oxide (Sm^3)','(Gas)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Peat (tonnes)','(Solid)','t','Peat','$/tonne',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('PEF (tonnes)','(Solid)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Petrochemical Feedstocks (kilolitres)','(Liquid)','t','Naphtha','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Petroleum Coke (kilolitres)','(Liquid)','t','Petroleum Coke','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Petroleum Coke - Refinery Use (kilolitres)','(Liquid)','t','Petroleum Coke','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Plastic (tonnes)','(Solid)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Propane (kilolitres)','(Liquid)','t','Propane','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Propylene (kilolitres)','(Liquid)','f','n/a','n/a',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Refinery Fuel Gas (Sm^3)','(Gas)','t','Refinery Gas','$/m3',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Rendered Animal Fat (kilolitres)','(Liquid)','f','n/a','n/a',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Residual Fuel Oil (#5 & 6) (kilolitres)','(Liquid)','t','Heavy Fuel Oil','$/litre',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('RFG - Mix Drum','(Gas)','t','Refinery Gas','$/m3',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('RFG - Reformer Gas','(Gas)','t','Refinery Gas','$/m3',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Roofing Tear-off (tonnes)','(Solid)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('SMR PSA Tail Gas (Sm^3)','(Gas)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Sodium Bicarbonate (tonnes)','(Solid)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Solid Byproducts (bone dry tonnes)','(Solid)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Spent Pulping Liquor (bone dry tonnes)','(Solid)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Still Gas - Refineries (Sm^3)','(Gas)','t','Refinery Gas','$/m3',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Still Gas (Sm^3)','(Gas)','t','Refinery Gas','$/m3',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Sub-Bituminous Coal (tonnes)','(Solid)','t','Low Heat Value Coal','$/tonne',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Tail Gas (Sm^3)','(Gas)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Tall Oil (kilolitres)','(Liquid)','f','n/a','n/a',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Tires - biomass component (bone dry tonnes)','(Solid)','t','Tires — Whole','$/tonne',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Tires - non-biomass component (tonnes)','(Solid)','t','Tires — Whole','$/tonne',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Trona (tonnes)','(Solid)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Turpentine (kilolitres)','(Liquid)','f','n/a','n/a',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Vegetable Oil (kilolitres)','(Liquid)','f','n/a','n/a',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Waste Oil (kilolitres)','(Liquid)','f','n/a','n/a',1000);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Wood Waste (bone dry tonnes)','(Solid)','f','n/a','n/a',1);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Flared Natural Gas CO2','Gas','t','Flaring','$/m3',1000000/2151);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Flared Natural Gas CH4','Gas','t','Flaring','$/m3',1000000/6.5);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Flared Natural Gas N20','Gas','t','Flaring','$/m3',1000000/0.06);
insert into ggircs_swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units, unit_conversion_factor) values ('Vented Natural Gas','Gas','t','Venting','$/m3',1);

commit;
