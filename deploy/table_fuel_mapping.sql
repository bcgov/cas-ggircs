-- Deploy ggircs:table_fuel_mapping to pg
-- requires: schema_ggircs_swrs

begin;

create table ggircs_swrs.fuel_mapping (
  id integer generated always as identity primary key,
  fuel_type varchar(1000),
  normalized_fuel_type varchar(1000),
  state varchar(1000),
  carbon_taxed varchar(1000),
  cta_mapping varchar(1000),
  cta_rate_units varchar(1000)

);

comment on table  ggircs_swrs.fuel_mapping is 'The fuel mapping table that maps fuel type with carbon tax rates';
comment on column ggircs_swrs.fuel_mapping.id is 'The internal primary key for the mapping';
comment on column ggircs_swrs.fuel_mapping.fuel_type is 'The type of fuel (from GHGR), Foreign key to fuel';
comment on column ggircs_swrs.fuel_mapping.normalized_fuel_type is 'The type of fuel (Normalized)';
comment on column ggircs_swrs.fuel_mapping.state is 'The state of the fuel (gas, liquid, solid)';
comment on column ggircs_swrs.fuel_mapping.carbon_taxed is 'Is the fuel carbon taxed';
comment on column ggircs_swrs.fuel_mapping.cta_mapping is 'Generalized high-level fuel type';
comment on column ggircs_swrs.fuel_mapping.cta_rate_units is 'The units of measure';

INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Acetylene', 'Acetylene (Sm^3)', '(Gas)', 'no', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Acetylene (Sm^3)', 'Acetylene (Sm^3)', '(Gas)', 'no', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Agricultural Byproducts (bone dry tonnes)', 'Agricultural Byproducts (bone dry tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Anthracite Coal (tonnes)', 'Anthracite Coal (tonnes)', '(Solid)', 'yes', 'High Heat Value Coal', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Asphalt & Road Oil (kilolitres)', 'Asphalt & Road Oil (kilolitres)', '(Liquid)', 'yes', 'Heavy Fuel Oil', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Aviation Gasoline (kilolitres)', 'Aviation Gasoline (kilolitres)', '(Liquid)', 'yes', 'Aviation Fuel', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Aviation Turbo Fuel (kilolitres)', 'Aviation Turbo Fuel (kilolitres)', '(Liquid)', 'yes', 'Aviation Fuel', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Biodiesel (100%) (kilolitres)', 'Biodiesel (100%) (kilolitres)', '(Liquid)', 'yes', 'Light Fuel Oil', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Biodiesel (100)', 'Biodiesel (100%) (kilolitres)', '(Liquid)', 'yes', 'Light Fuel Oil', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Biodiesel (100) (kilolitres)', 'Biodiesel (100%) (kilolitres)', '(Liquid)', 'yes', 'Light Fuel Oil', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Biogas (captured methane) (Sm^3)', 'Biogas (captured methane) (Sm^3)', '(Gas)', 'NO', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Bituminous Coal', 'Bituminous Coal (tonnes)', '(Solid)', 'yes', 'High Heat Value Coal', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Bituminous Coal (tonnes)', 'Bituminous Coal (tonnes)', '(Solid)', 'yes', 'High Heat Value Coal', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Bone char - organics', 'Bone char - organics (tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Bone char - organics (tonnes)', 'Bone char - organics (tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Butane (kilolitres)', 'Butane (kilolitres)', '(Liquid)', 'yes', 'Butane', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Butylene (kilolitres)', 'Butylene (kilolitres)', '(Liquid)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('C/D Waste - Plastic (tonnes)', 'C/D Waste - Plastic (tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('C/D Waste - Wood (tonnes)', 'C/D Waste - Wood (tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Cloth (tonnes)', 'Cloth (tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('CNCG', 'CNCGs (Sm^3)', '(Gas)', 'no', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('CNCGs (Sm^3)', 'CNCGs (Sm^3)', '(Gas)', 'no', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Coal Coke (tonnes)', 'Coal Coke (tonnes)', '(Solid)', 'yes', 'Coke', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Coal/PetCoke  blend (tonnes)', 'Coal/PetCoke  blend (tonnes)', '(Solid)', 'yes', 'Coke', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Coke Oven Gas (Sm^3)', 'Coke Oven Gas (Sm^3)', '(Gas)', 'yes', 'Coke Oven Gas', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Combustible Tall Oil', 'Combustible Tall Oil (kilolitres)', '(Liquid)', 'no', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Combustible Tall Oil (kilolitres)', 'Combustible Tall Oil (kilolitres)', '(Liquid)', 'no', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Concentrated non-condensable gases (CNCGs)', 'CNCGs (Sm^3)', '(Gas)', 'no', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Concentrated Non-condensible Gas', 'CNCGs (Sm^3)', '(Gas)', 'no', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Concentrated Non-condensible Gases', 'CNCGs (Sm^3)', '(Gas)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Concentrated Non-Condensible Gases (CNCG)', 'CNCGs (Sm^3)', '(Gas)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Concentrated non-condensible gases (CNCGs)', 'CNCGs (Sm^3)', '(Gas)', 'no', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Concentrated non-condensible gases (CNCGs) (Sm^3)', 'CNCGs (Sm^3)', '(Gas)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Concentrated non-condensible gases from kraft process', 'CNCGs (Sm^3)', '(Gas)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Crude Oil (kilolitres)', 'Crude Oil (kilolitres)', '(Liquid)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Crude Sulfate Turpentine (CST)', 'Crude Sulfate Turpentine (CST) (kilolitres)', '(Liquid)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Crude Sulfate Turpentine (CST) (kilolitres)', 'Crude Sulfate Turpentine (CST) (kilolitres)', '(Liquid)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Crude Tall Oil (CTO)', 'Crude Tall Oil (CTO) (kilolitres)', '(Liquid)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Crude Tall Oil (CTO) (kilolitres)', 'Crude Tall Oil (CTO) (kilolitres)', '(Liquid)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Diesel (kilolitres)', 'Diesel (kilolitres)', '(Liquid)', 'yes', 'Light Fuel Oil', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Digester Gas', 'Digester Gas (Sm^3)', '(Gas)', 'NO', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Digester Gas (Sm^3)', 'Digester Gas (Sm^3)', '(Gas)', 'NO', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Dilute non-condensable gases (DNCGs)', 'DNCGs (Sm^3)', '(Gas)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Dilute Non-condensible Gas', 'DNCGs (Sm^3)', '(Gas)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Dilute non-condensible gases (DNCGs)', 'DNCGs (Sm^3)', '(Gas)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Dilute non-condensible gases (DNCGs) (Sm^3)', 'DNCGs (Sm^3)', '(Gas)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Dilute non-condensible gases from kraft process', 'DNCGs (Sm^3)', '(Gas)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Distilate Fuel Oil No.1', 'Distilate Fuel Oil No.1 (kilolitres)', '(Liquid)', 'yes', 'Light Fuel Oil', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Distilate Fuel Oil No.1 (kilolitres)', 'Distilate Fuel Oil No.1 (kilolitres)', '(Liquid)', 'yes', 'Light Fuel Oil', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Distilate Fuel Oil No.2', 'Distilate Fuel Oil No.2 (kilolitres)', '(Liquid)', 'yes', 'Light Fuel Oil', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Distilate Fuel Oil No.2 (kilolitres)', 'Distilate Fuel Oil No.2 (kilolitres)', '(Liquid)', 'yes', 'Light Fuel Oil', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Distilate Fuel Oil No.4 (kilolitres)', 'Distilate Fuel Oil No.4 (kilolitres)', '(Liquid)', 'yes', 'Light Fuel Oil', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('DNCG', 'DNCGs (Sm^3)', '(Gas)', 'no', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('DNCG''s', 'DNCGs (Sm^3)', '(Gas)', 'no', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('DNCGs (Sm^3)', 'DNCGs (Sm^3)', '(Gas)', 'no', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Ethane (kilolitres)', 'Ethane (kilolitres)', '(Liquid)', 'yes', 'Ethane', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Ethanol (100%) (kilolitres)', 'Ethanol (100%) (kilolitres)', '(Liquid)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Ethylene (kilolitres)', 'Ethylene (kilolitres)', '(Liquid)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('E-Waste', 'E-Waste (tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('E-Waste (tonnes)', 'E-Waste (tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Explosives', 'Explosives (tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Explosives (tonnes)', 'Explosives (tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Field Gas', 'Field Gas (Sm^3)', '(Gas)', 'yes', 'Natural Gas', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Field Gas (Sm^3)', 'Field Gas (Sm^3)', '(Gas)', 'yes', 'Natural Gas', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Field gas or process vent gas', 'Field gas or process vent gas  (Sm^3)', '(Gas)', 'yes', 'Natural Gas', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Field gas or process vent gas  (Sm^3)', 'Field gas or process vent gas  (Sm^3)', '(Gas)', 'yes', 'Natural Gas', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Foreign Bituminous Coal (tonnes)', 'Foreign Bituminous Coal (tonnes)', '(Solid)', 'yes', 'High Heat Value Coal', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Isobutane (kilolitres)', 'Isobutane (kilolitres)', '(Liquid)', 'yes', 'Butane', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Isobutylene (kilolitres)', 'Isobutylene (kilolitres)', '(Liquid)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Kerosene', 'Kerosene (kilolitres)', '(Liquid)', 'yes', 'Kerosene', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Kerosene (kilolitres)', 'Kerosene (kilolitres)', '(Liquid)', 'yes', 'Kerosene', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Kerosene-type Jet Fuel (kilolitres)', 'Kerosene-type Jet Fuel (kilolitres)', '(Liquid)', 'yes', 'Jet Fuel', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Landfill Gas', 'Landfill Gas (Sm^3)', '(Gas)', 'NO', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Landfill Gas (Sm^3)', 'Landfill Gas (Sm^3)', '(Gas)', 'NO', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Light Fuel Oil (kilolitres)', 'Light Fuel Oil (kilolitres)', '(Liquid)', 'yes', 'Light Fuel Oil', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Lignite (tonnes)', 'Lignite (tonnes)', '(Solid)', 'yes', 'Low Heat Value Coal', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Liquified Petroleum Gases (LPG', 'Liquified Petroleum Gases (LPG) (kilolitres)', '(Liquid)', 'yes', 'Gas Liquids', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Liquified Petroleum Gases (LPG) (kilolitres)', 'Liquified Petroleum Gases (LPG) (kilolitres)', '(Liquid)', 'yes', 'Gas Liquids', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Lubricants (kilolitres)', 'Lubricants (kilolitres)', '(Liquid)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Motor Gasoline', 'Motor Gasoline (kilolitres)', '(Liquid)', 'yes', 'Gasoline', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Motor Gasoline - Off-Road (kilolitres)', 'Motor Gasoline - Off-Road (kilolitres)', '(Liquid)', 'yes', 'Gasoline', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Motor Gasoline (kilolitres)', 'Motor Gasoline (kilolitres)', '(Liquid)', 'yes', 'Gasoline', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Municipal Solid Waste - biomas', 'Municipal Solid Waste - biomass component (bone dry tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Municipal Solid Waste - biomass component (bone dry tonnes)', 'Municipal Solid Waste - biomass component (bone dry tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Municipal Solid Waste - non-bi', 'Municipal Solid Waste - non-biomass component (tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Municipal Solid Waste - non-biomass component', 'Municipal Solid Waste - non-biomass component (tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Municipal Solid Waste - non-biomass component (tonnes)', 'Municipal Solid Waste - non-biomass component (tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Naphtha (kilolitres)', 'Naphtha (kilolitres)', '(Liquid)', 'yes', 'Naphtha', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Natural Gas', 'Natural Gas (Sm^3)', '(Gas)', 'yes', 'Natural Gas', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Natural Gas (Sm^3)', 'Natural Gas (Sm^3)', '(Gas)', 'yes', 'Natural Gas', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Natural Gasoline', 'Natural Gasoline (kilolitres)', '(Liquid)', 'yes', 'Gasoline', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Natural Gasoline (kilolitres)', 'Natural Gasoline (kilolitres)', '(Liquid)', 'yes', 'Gasoline', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Nitrous Oxide', 'Nitrous Oxide (Sm^3)', '(Gas)', 'no', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Nitrous Oxide (Sm^3)', 'Nitrous Oxide (Sm^3)', '(Gas)', 'no', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Peat (tonnes)', 'Peat (tonnes)', '(Solid)', 'yes', 'Peat', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('PEF (tonnes)', 'PEF (tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Petrochemical Feedstocks (kilolitres)', 'Petrochemical Feedstocks (kilolitres)', '(Liquid)', 'yes', 'Naphtha', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Petroleum Coke', 'Petroleum Coke (kilolitres)', '(Liquid)', 'yes', 'Petroleum Coke', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Petroleum Coke - Refinery Use (kilolitres)', 'Petroleum Coke - Refinery Use (kilolitres)', '(Liquid)', 'yes', 'Petroleum Coke', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Petroleum Coke (kilolitres)', 'Petroleum Coke (kilolitres)', '(Liquid)', 'yes', 'Petroleum Coke', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Plastic (tonnes)', 'Plastic (tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Propane (kilolitres)', 'Propane (kilolitres)', '(Liquid)', 'yes', 'Propane', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Propylene (kilolitres)', 'Propylene (kilolitres)', '(Liquid)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Refinery Fuel Gas', 'Refinery Fuel Gas (Sm^3)', '(Gas)', 'yes', 'Refinery Gas', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Refinery Fuel Gas (Sm^3)', 'Refinery Fuel Gas (Sm^3)', '(Gas)', 'yes', 'Refinery Gas', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Rendered Animal Fat (kilolitres)', 'Rendered Animal Fat (kilolitres)', '(Liquid)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Residual Fuel Oil (#5 & 6)', 'Residual Fuel Oil (#5 & 6) (kilolitres)', '(Liquid)', 'yes', 'Heavy Fuel Oil', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Residual Fuel Oil (#5 & 6) (kilolitres)', 'Residual Fuel Oil (#5 & 6) (kilolitres)', '(Liquid)', 'yes', 'Heavy Fuel Oil', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('RFG - Mix Drum', 'RFG - Mix Drum', '(Gas)', 'yes', 'Refinery Gas', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('RFG - Reformer Gas', 'RFG - Reformer Gas', '(Gas)', 'yes', 'Refinery Gas', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Roofing Tear-off (tonnes)', 'Roofing Tear-off (tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('SMR PSA Tail Gas', 'SMR PSA Tail Gas (Sm^3)', '(Gas)', 'no', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('SMR PSA Tail Gas (Sm^3)', 'SMR PSA Tail Gas (Sm^3)', '(Gas)', 'no', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Sodium Bicarbonate', 'Sodium Bicarbonate (tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Sodium Bicarbonate (tonnes)', 'Sodium Bicarbonate (tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Solid Byproducts', 'Solid Byproducts (bone dry tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Solid Byproducts (bone dry tonnes)', 'Solid Byproducts (bone dry tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Spent Pulping Liquor', 'Spent Pulping Liquor (bone dry tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Spent Pulping Liquor (bone dry tonnes)', 'Spent Pulping Liquor (bone dry tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Still Gas', 'Still Gas (Sm^3)', '(Gas)', 'yes', 'Refinery Gas', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Still Gas - Refineries (Sm^3)', 'Still Gas - Refineries (Sm^3)', '(Gas)', 'yes', 'Refinery Gas', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Still Gas (Sm^3)', 'Still Gas (Sm^3)', '(Gas)', 'yes', 'Refinery Gas', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Sub-Bituminous Coal', 'Sub-Bituminous Coal (tonnes)', '(Solid)', 'yes', 'Low Heat Value Coal', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Sub-Bituminous Coal (tonnes)', 'Sub-Bituminous Coal (tonnes)', '(Solid)', 'yes', 'Low Heat Value Coal', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Tail Gas (Sm^3)', 'Tail Gas (Sm^3)', '(Gas)', 'no', 'n/a', '$/m3');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Tall Oil (kilolitres)', 'Tall Oil (kilolitres)', '(Liquid)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Tires - biomass component (bone dry tonnes)', 'Tires - biomass component (bone dry tonnes)', '(Solid)', 'yes', 'Tires — Whole', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Tires - non-biomass component', 'Tires - non-biomass component (tonnes)', '(Solid)', 'yes', 'Tires — Whole', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Tires - non-biomass component (tonnes)', 'Tires - non-biomass component (tonnes)', '(Solid)', 'yes', 'Tires — Whole', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Trona (tonnes)', 'Trona (tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Turpentine', 'Turpentine (kilolitres)', '(Liquid)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Turpentine (kilolitres)', 'Turpentine (kilolitres)', '(Liquid)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Vegetable Oil (kilolitres)', 'Vegetable Oil (kilolitres)', '(Liquid)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Waste Oil (kilolitres)', 'Waste Oil (kilolitres)', '(Liquid)', 'no', 'n/a', '$/litre');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Wood Waste', 'Wood Waste (bone dry tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');
INSERT INTO ggircs_swrs.fuel_mapping (fuel_type, normalized_fuel_type, state, carbon_taxed, cta_mapping, cta_rate_units) VALUES ('Wood Waste (bone dry tonnes)', 'Wood Waste (bone dry tonnes)', '(Solid)', 'no', 'n/a', '$/tonne');

commit;
