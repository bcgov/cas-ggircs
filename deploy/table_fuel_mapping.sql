-- Deploy ggircs:table_fuel_mapping to pg
-- requires: schema_ggircs_swrs

begin;

create table ggircs_swrs.fuel_mapping (
  id integer generated always as identity primary key,
  fuel_type varchar(1000),
  normalized_fuel_type varchar(1000),
  state varchar(1000),
  carbon_taxed boolean,
  cta_mapping varchar(1000),
  cta_rate_units varchar(1000),
  unit_conversion_factor integer

);

comment on table  ggircs_swrs.fuel_mapping is 'The fuel mapping table that maps fuel type with carbon tax rates';
comment on column ggircs_swrs.fuel_mapping.id is 'The internal primary key for the mapping';
comment on column ggircs_swrs.fuel_mapping.fuel_type is 'The type of fuel (from GHGR), Foreign key to fuel';


create unique index ggircs_swrs_fuel_mapping_fuel_type on ggircs_swrs.fuel_mapping(fuel_type);

INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (1, 'Acetylene', 1);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (2, 'Acetylene (Sm^3)', 1);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (3, 'Agricultural Byproducts (bone dry tonnes)', 2);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (4, 'Anthracite Coal (tonnes)', 3);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (5, 'Asphalt & Road Oil (kilolitres)', 4);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (6, 'Aviation Gasoline (kilolitres)', 5);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (7, 'Aviation Turbo Fuel (kilolitres)', 6);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (8, 'Biodiesel (100)', 7);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (9, 'Biodiesel (100) (kilolitres)', 7);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (10, 'Biodiesel (100%) (kilolitres)', 7);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (11, 'Biogas (captured methane) (Sm^3)', 8);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (12, 'Bituminous Coal', 9);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (13, 'Bituminous Coal (tonnes)', 9);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (14, 'Bone char - organics', 10);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (15, 'Bone char - organics (tonnes)', 10);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (16, 'Butane (kilolitres)', 11);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (17, 'Butylene (kilolitres)', 12);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (18, 'C/D Waste - Plastic (tonnes)', 13);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (19, 'C/D Waste - Wood (tonnes)', 14);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (20, 'Cloth (tonnes)', 15);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (21, 'CNCG', 16);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (22, 'CNCGs (Sm^3)', 16);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (23, 'Coal Coke (tonnes)', 17);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (24, 'Coal/PetCoke  blend (tonnes)', 18);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (25, 'Coke Oven Gas (Sm^3)', 19);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (26, 'Combustible Tall Oil', 20);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (27, 'Combustible Tall Oil (kilolitres)', 20);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (28, 'Concentrated non-condensable gases (CNCGs)', 16);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (29, 'Concentrated Non-condensible Gas', 16);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (30, 'Concentrated Non-condensable Gases', 16);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (31, 'Concentrated Non-condensible Gases', 16);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (32, 'Concentrated Non-Condensible Gases (CNCG)', 16);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (33, 'Concentrated non-condensible gases (CNCGs)', 16);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (34, 'Concentrated non-condensible gases (CNCGs) (Sm^3)', 16);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (35, 'Concentrated non-condensible gases from kraft process', 16);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (36, 'Crude Oil (kilolitres)', 21);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (37, 'Crude Sulfate Turpentine (CST)', 22);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (38, 'Crude Sulfate Turpentine (CST) (kilolitres)', 22);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (39, 'Crude Tall Oil (CTO)', 23);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (40, 'Crude Tall Oil (CTO) (kilolitres)', 23);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (41, 'Diesel', 24);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (42, 'Diesel (kilolitres)', 24);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (43, 'Digester Gas', 25);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (44, 'Digester Gas (Sm^3)', 25);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (45, 'Dilute non-condensable gases (DNCGs)', 29);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (46, 'Dilute Non-condensible Gas', 29);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (47, 'Dilute non-condensible gases (DNCGs)', 29);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (48, 'Dilute non-condensible gases (DNCGs) (Sm^3)', 29);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (49, 'Dilute non-condensible gases from kraft process', 29);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (50, 'Distilate Fuel Oil No.1', 26);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (51, 'Distilate Fuel Oil No.1 (kilolitres)', 26);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (52, 'Distilate Fuel Oil No.2', 27);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (53, 'Distilate Fuel Oil No.2 (kilolitres)', 27);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (54, 'Distilate Fuel Oil No.4 (kilolitres)', 28);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (55, 'DNCG', 29);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (56, 'DNCG''s', 29);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (57, 'DNCGs (Sm^3)', 29);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (58, 'E-Waste', 33);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (59, 'E-Waste (tonnes)', 33);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (60, 'Ethane (kilolitres)', 30);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (61, 'Ethanol (100%) (kilolitres)', 31);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (62, 'Ethylene (kilolitres)', 32);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (63, 'Explosives', 34);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (64, 'Explosives (tonnes)', 34);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (65, 'Field Gas', 36);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (66, 'Field Gas (Sm^3)', 36);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (67, 'Field gas or process vent gas', 35);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (68, 'Field gas or process vent gas  (Sm^3)', 35);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (69, 'Foreign Bituminous Coal (tonnes)', 37);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (70, 'Isobutane (kilolitres)', 38);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (71, 'Isobutylene (kilolitres)', 39);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (72, 'Kerosene', 40);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (73, 'Kerosene (kilolitres)', 40);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (74, 'Kerosene-type Jet Fuel (kilolitres)', 41);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (75, 'Landfill Gas', 42);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (76, 'Landfill Gas (Sm^3)', 42);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (77, 'Light Fuel Oil', 43);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (78, 'Light Fuel Oil (kilolitres)', 43);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (79, 'Lignite (tonnes)', 44);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (80, 'Liquified Petroleum Gases (LPG)', 45);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (81, 'Liquified Petroleum Gases (LPG) (kilolitres)', 45);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (82, 'Lubricants', 46);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (83, 'Lubricants (kilolitres)', 46);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (84, 'Motor Gasoline', 47);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (85, 'Motor Gasoline - Off-Road (kilolitres)', 48);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (86, 'Motor Gasoline (kilolitres)', 47);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (87, 'Municipal Solid Waste - biomas', 49);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (88, 'Municipal Solid Waste - biomass component', 49);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (89, 'Municipal Solid Waste - biomass component (bone dry tonnes)', 49);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (90, 'Municipal Solid Waste - non-bi', 50);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (91, 'Municipal Solid Waste - non-biomass component', 50);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (92, 'Municipal Solid Waste - non-biomass component (tonnes)', 50);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (93, 'Naphtha', 51);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (94, 'Naphtha (kilolitres)', 51);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (95, 'Natural Gas', 53);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (96, 'Natural Gas (Sm^3)', 53);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (97, 'Natural Gasoline', 52);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (98, 'Natural Gasoline (kilolitres)', 52);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (99, 'Nitrous Oxide', 54);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (100, 'Nitrous Oxide (Sm^3)', 54);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (101, 'Peat (tonnes)', 55);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (102, 'PEF (tonnes)', 56);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (103, 'Petrochemical Feedstocks (kilolitres)', 57);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (104, 'Petroleum Coke', 58);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (105, 'Petroleum Coke - Refinery Use (kilolitres)', 59);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (106, 'Petroleum Coke (kilolitres)', 58);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (107, 'Plastic (tonnes)', 60);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (108, 'Propane ', 61);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (109, 'Propane', 61);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (110, 'Propane (kilolitres)', 61);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (111, 'Propylene (kilolitres)', 62);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (112, 'Refinery Fuel Gas', 63);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (113, 'Refinery Fuel Gas (Sm^3)', 63);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (114, 'Rendered Animal Fat (kilolitres)', 64);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (115, 'Residual Fuel Oil (#5 & 6)', 65);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (116, 'Residual Fuel Oil (#5 & 6) (kilolitres)', 65);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (117, 'RFG - Mix Drum', 66);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (118, 'RFG - Reformer Gas', 67);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (119, 'Roofing Tear-off (tonnes)', 68);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (120, 'SMR PSA Tail Gas', 69);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (121, 'SMR PSA Tail Gas (Sm^3)', 69);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (122, 'Sodium Bicarbonate', 70);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (123, 'Sodium Bicarbonate (tonnes)', 70);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (124, 'Solid Byproducts', 71);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (125, 'Solid Byproducts (bone dry tonnes)', 71);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (126, 'Spent Pulping Liquor', 72);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (127, 'Spent Pulping Liquor (bone dry tonnes)', 72);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (128, 'Still Gas', 74);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (129, 'Still Gas - Refineries (Sm^3)', 73);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (130, 'Still Gas (Sm^3)', 74);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (131, 'Sub-Bituminous Coal', 75);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (132, 'Sub-Bituminous Coal (tonnes)', 75);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (133, 'Tail Gas (Sm^3)', 76);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (134, 'Tall Oil (kilolitres)', 77);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (135, 'Tires - biomass component (bone dry tonnes)', 78);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (136, 'Tires - non-biomass component', 79);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (137, 'Tires - non-biomass component (tonnes)', 79);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (138, 'Trona (tonnes)', 80);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (139, 'Turpentine', 81);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (140, 'Turpentine (kilolitres)', 81);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (141, 'Vegetable Oil (kilolitres)', 82);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (142, 'Waste Oil (kilolitres)', 83);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (143, 'Wood Waste', 84);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (144, 'Wood Waste (bone dry tonnes)', 84);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (145, 'Flared Natural Gas', 85);
INSERT INTO ggircs_swrs.fuel_mapping (id, fuel_type, fuel_carbon_tax_details_id) VALUES (146, 'Vented Natural Gas', 86);

update ggircs_swrs.fuel_mapping

commit;
