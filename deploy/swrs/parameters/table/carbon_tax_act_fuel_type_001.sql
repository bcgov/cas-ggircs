-- Deploy ggircs:swrs/parameters/table/carbon_tax_act_fuel_type_001 to pg
-- requires: swrs/parameters/table/carbon_tax_act_fuel_type

begin;

alter table ggircs_parameters.carbon_tax_act_fuel_type add column cta_rate_units varchar(1000);
alter table ggircs_parameters.carbon_tax_act_fuel_type add column metadata varchar(10000);

/** Add the Combustible Waste fuel type **/
insert into ggircs_parameters.carbon_tax_act_fuel_type (
  carbon_tax_fuel_type,
  cta_rate_units,
  metadata
) values (
  'Combustible Waste',
  '$/tonne',
  $$
    Combustible Waste was added to the carbon tax act Schedule 2 for the period starting April 1 2020.
    Combustible Waste means the following:
    (a) tires, whether shredded or whole;
    (b) asphalt shingles, whether in part or whole;
    (c) a prescribed substance, material or thing.
  $$
);

/** Set cta_rate_units **/
update ggircs_parameters.carbon_tax_act_fuel_type set cta_rate_units = '$/litre'
where carbon_tax_fuel_type in (
  'Aviation Fuel',
  'Gasoline',
  'Heavy Fuel Oil',
  'Jet Fuel',
  'Kerosene',
  'Light Fuel Oil',
  'Methanol',
  'Naphtha',
  'Butane',
  'Coke Oven Gas',
  'Ethane',
  'Propane',
  'Petroleum Coke',
  'Gas Liquids',
  'Pentanes Plus'
);

update ggircs_parameters.carbon_tax_act_fuel_type set cta_rate_units = '$/m3'
where carbon_tax_fuel_type in (
  'Coke Oven Gas',
  'Natural Gas',
  'Refinery Gas'
);

update ggircs_parameters.carbon_tax_act_fuel_type set cta_rate_units = '$/tonne'
where carbon_tax_fuel_type in (
  'High Heat Value Coal',
  'Low Heat Value Coal',
  'Coke',
  'Peat',
  'Tires - Shredded',
  'Tires - Whole'
);

/** Add metadata **/
update ggircs_parameters.carbon_tax_act_fuel_type set metadata = 'Tires - Shredded and Tires - Whole had different carbon tax rates until the period ending March 31 2020. These rates were harmonized during the period starting April 1 2020 to match the rate for the Combustible Waste fuel type'
where carbon_tax_fuel_type in (
  'Tires - Shredded',
  'Tires - Whole'
);

commit
