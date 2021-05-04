-- Deploy ggircs:swrs/transform/function/load_fuel_carbon_tax_details to pg
-- requires: swrs/transform/schema
-- requires: swrs/public/table/fuel_carbon_tax_details

BEGIN;

create or replace function swrs_transform.load_fuel_carbon_tax_details()
  returns void as
$function$
    begin
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Acetylene (Sm^3)','(Gas)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Agricultural Byproducts (bone dry tonnes)','(Solid)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Anthracite Coal (tonnes)','(Solid)',15,'$/tonne',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Asphalt & Road Oil (kilolitres)','(Liquid)',3,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Aviation Gasoline (kilolitres)','(Liquid)',1,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Aviation Turbo Fuel (kilolitres)','(Liquid)',1,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Biodiesel (100%) (kilolitres)','(Liquid)',6,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Biogas (captured methane) (Sm^3)','(Gas)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Bituminous Coal (tonnes)','(Solid)',15,'$/tonne',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Bone char - organics (tonnes)','(Solid)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Butane (kilolitres)','(Liquid)',9,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Butylene (kilolitres)','(Liquid)',null,'n/a',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('C/D Waste - Plastic (tonnes)','(Solid)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('C/D Waste - Wood (tonnes)','(Solid)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Cloth (tonnes)','(Solid)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('CNCGs (Sm^3)','(Gas)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Coal Coke (tonnes)','(Solid)',17,'$/tonne',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Coal/PetCoke  blend (tonnes)','(Solid)',17,'$/tonne',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Coke Oven Gas (Sm^3)','(Gas)',10,'$/m3',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Combustible Tall Oil (kilolitres)','(Liquid)',null,'n/a',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Crude Oil (kilolitres)','(Liquid)',null,'n/a',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Crude Sulfate Turpentine (CST) (kilolitres)','(Liquid)',null,'n/a',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Crude Tall Oil (CTO) (kilolitres)','(Liquid)',null,'n/a',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Diesel (kilolitres)','(Liquid)',6,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Digester Gas (Sm^3)','(Gas)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Distilate Fuel Oil No.1 (kilolitres)','(Liquid)',6,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Distilate Fuel Oil No.2 (kilolitres)','(Liquid)',6,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Distilate Fuel Oil No.4 (kilolitres)','(Liquid)',6,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('DNCGs (Sm^3)','(Gas)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Ethane (kilolitres)','(Liquid)',11,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Ethanol (100%) (kilolitres)','(Liquid)',null,'n/a',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Ethylene (kilolitres)','(Liquid)',null,'n/a',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('E-Waste (tonnes)','(Solid)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Explosives (tonnes)','(Solid)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Field gas or process vent gas  (Sm^3)','(Gas)',13,'$/m3',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Field Gas (Sm^3)','(Gas)',13,'$/m3',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Foreign Bituminous Coal (tonnes)','(Solid)',15,'$/tonne',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Isobutane (kilolitres)','(Liquid)',9,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Isobutylene (kilolitres)','(Liquid)',null,'n/a',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Kerosene (kilolitres)','(Liquid)',5,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Kerosene-type Jet Fuel (kilolitres)','(Liquid)',4,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Landfill Gas (Sm^3)','(Gas)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Light Fuel Oil (kilolitres)','(Liquid)',6,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Lignite (tonnes)','(Solid)',16,'$/tonne',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Liquified Petroleum Gases (LPG) (kilolitres)','(Liquid)',19,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Lubricants (kilolitres)','(Liquid)',null,'n/a',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Motor Gasoline (kilolitres)','(Liquid)',2,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Motor Gasoline - Off-Road (kilolitres)','(Liquid)',2,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Municipal Solid Waste - biomass component (bone dry tonnes)','(Solid)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Municipal Solid Waste - non-biomass component (tonnes)','(Solid)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Naphtha (kilolitres)','(Liquid)',8,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Natural Gasoline (kilolitres)','(Liquid)',2,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Natural Gas (Sm^3)','(Gas)',13,'$/m3',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Nitrous Oxide (Sm^3)','(Gas)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Peat (tonnes)','(Solid)',21,'$/tonne',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('PEF (tonnes)','(Solid)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Petrochemical Feedstocks (kilolitres)','(Liquid)',8,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Petroleum Coke (kilolitres)','(Liquid)',18,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Petroleum Coke - Refinery Use (kilolitres)','(Liquid)',18,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Plastic (tonnes)','(Solid)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Propane (kilolitres)','(Liquid)',12,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Propylene (kilolitres)','(Liquid)',null,'n/a',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Refinery Fuel Gas (Sm^3)','(Gas)',14,'$/m3',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Rendered Animal Fat (kilolitres)','(Liquid)',null,'n/a',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Residual Fuel Oil (#5 & 6) (kilolitres)','(Liquid)',3,'$/litre',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('RFG - Mix Drum','(Gas)',14,'$/m3',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('RFG - Reformer Gas','(Gas)',14,'$/m3',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Roofing Tear-off (tonnes)','(Solid)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('SMR PSA Tail Gas (Sm^3)','(Gas)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Sodium Bicarbonate (tonnes)','(Solid)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Solid Byproducts (bone dry tonnes)','(Solid)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Spent Pulping Liquor (bone dry tonnes)','(Solid)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Still Gas - Refineries (Sm^3)','(Gas)',14,'$/m3',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Still Gas (Sm^3)','(Gas)',14,'$/m3',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Sub-Bituminous Coal (tonnes)','(Solid)',16,'$/tonne',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Tail Gas (Sm^3)','(Gas)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Tall Oil (kilolitres)','(Liquid)',null,'n/a',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Tires - biomass component (bone dry tonnes)','(Solid)',23,'$/tonne',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Tires - non-biomass component (tonnes)','(Solid)',23,'$/tonne',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Trona (tonnes)','(Solid)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Turpentine (kilolitres)','(Liquid)',null,'n/a',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Vegetable Oil (kilolitres)','(Liquid)',null,'n/a',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Waste Oil (kilolitres)','(Liquid)',null,'n/a',1000);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Wood Waste (bone dry tonnes)','(Solid)',null,'n/a',1);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Flared Natural Gas CO2','Gas',null,'$/m3',1000000/2151);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Flared Natural Gas CH4','Gas',null,'$/m3',1000000/6.5);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Flared Natural Gas N20','Gas',null,'$/m3',1000000/0.06);
        insert into swrs_load.fuel_carbon_tax_details (normalized_fuel_type, state, carbon_tax_act_fuel_type_id, cta_rate_units, unit_conversion_factor) values ('Vented Natural Gas','Gas',null,'$/m3',1);
    end
$function$ language plpgsql volatile;
COMMIT;
