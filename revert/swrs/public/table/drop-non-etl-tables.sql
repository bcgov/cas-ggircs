-- Revert ggircs:swrs/public/table/drop-non-etl-tables from pg

begin;

create table swrs.carbon_tax_act_fuel_type (
  id integer generated always as identity primary key,
  carbon_tax_fuel_type varchar(1000) not null
);

comment on table  swrs.carbon_tax_act_fuel_type is 'Table contains the list of fuels as defined by the carbon tax act https://www.bclaws.gov.bc.ca/civix/document/id/complete/statreg/08040_01';
comment on column swrs.carbon_tax_act_fuel_type.id is 'The internal primary key';
comment on column swrs.carbon_tax_act_fuel_type.carbon_tax_fuel_type is 'Fuel type defined by the carbon tax act';


create table swrs.emission_category (
  id integer primary key generated always as identity,
  swrs_emission_category varchar(1000) unique,
  carbon_taxed boolean default true,
  category_definition varchar(100000)
);

comment on table swrs.emission_category is 'Table of emission categories used in the CIIP program as defined in Schedule A / Schedule B of the Greenhouse Gas Industrial Reporting and Control Act (https://www.bclaws.gov.bc.ca/civix/document/id/complete/statreg/249_2015#ScheduleA)';
comment on column swrs.emission_category.id is 'Unique ID for the emission_category';
comment on column swrs.emission_category.swrs_emission_category is 'The emission category name as displayed in the swrs xml reports';
comment on column swrs.emission_category.carbon_taxed is 'Boolean carbon_taxed column indicates whether or not a fuel reported in this category is taxed';
comment on column swrs.emission_category.category_definition is 'Definition of the emission_category as defined in Schedule A / Schedule B of the Greenhouse Gas Industrial Reporting and Control Act (https://www.bclaws.gov.bc.ca/civix/document/id/complete/statreg/249_2015#ScheduleA)';



create table swrs.fuel_carbon_tax_details (
  id integer generated always as identity primary key,
  carbon_tax_act_fuel_type_id int references swrs.carbon_tax_act_fuel_type(id),
  normalized_fuel_type varchar(1000),
  state varchar(1000),
  cta_rate_units varchar(1000),
  unit_conversion_factor integer
);

create index swrs_ctd_ct_fuels_fkey on swrs.fuel_carbon_tax_details(carbon_tax_act_fuel_type_id);

comment on table  swrs.fuel_carbon_tax_details is 'The fuel mapping table that maps fuel type with carbon tax rates';
comment on column swrs.fuel_carbon_tax_details.id is 'The internal primary key for the mapping';
comment on column swrs.fuel_carbon_tax_details.carbon_tax_act_fuel_type_id is 'The foreign key that maps to the carbon_tax_act_fuel_type table';
comment on column swrs.fuel_carbon_tax_details.normalized_fuel_type is 'The type of fuel (Normalized)';
comment on column swrs.fuel_carbon_tax_details.state is 'The state of the fuel (gas, liquid, solid)';
comment on column swrs.fuel_carbon_tax_details.cta_rate_units is 'The units of measure';
comment on column swrs.fuel_carbon_tax_details.unit_conversion_factor is 'The conversion factor for cta units to reported units';


create table swrs.fuel_charge (
  id integer generated always as identity primary key,
  carbon_tax_act_fuel_type_id int references swrs.carbon_tax_act_fuel_type(id),
  fuel_charge numeric,
  start_date date,
  end_date date,
  metadata varchar(10000)
);

create index swrs_fuel_charge_ct_fuels_foreign_key on swrs.fuel_charge(carbon_tax_act_fuel_type_id);

comment on table swrs.fuel_charge is 'The fuel charge table contains the carbon tax fuel charge rate band for each fuel';
comment on column swrs.fuel_charge.id is 'The internal primary key';
comment on column swrs.fuel_charge.carbon_tax_act_fuel_type_id is 'Foreign key references the carbon_tax_act_fuel_type table';
comment on column swrs.fuel_charge.fuel_charge is 'The ministry-defined fuel charge pertaining to a specific fuel type';
comment on column swrs.fuel_charge.start_date is 'The date on which the fuel charge rate band came into effect';
comment on column swrs.fuel_charge.end_date is 'The date on which the fuel charge rate band stops/stopped being used';
comment on column swrs.fuel_charge.metadata is 'Column contains metadata pertaining to each fuel charge row';


create table swrs.fuel_mapping (
  id integer generated always as identity primary key,
  fuel_type varchar(1000),
  fuel_carbon_tax_details_id integer

);

comment on table  swrs.fuel_mapping is 'DEPRECATED The fuel mapping table that maps fuel type with carbon tax rates';
comment on column swrs.fuel_mapping.id is 'The internal primary key for the mapping';
comment on column swrs.fuel_mapping.fuel_type is 'The type of fuel (from GHGR), Foreign key to fuel';
comment on column swrs.fuel_mapping.fuel_carbon_tax_details_id is 'The foreign key to swrs.fuel_carbon_tax_details';

create unique index ggircs_swrs_fuel_mapping_fuel_type on swrs.fuel_mapping(fuel_type);
create index fuel_mapping_ct_details_foreign_key on swrs.fuel_mapping(fuel_carbon_tax_details_id);


create table swrs.naics_category (
  id integer generated always as identity primary key,
  naics_category varchar(1000)
);

comment on table  swrs.naics_category is 'The fuel mapping table that maps naics codes with hhw and irc categories';
comment on column swrs.naics_category.id is 'The internal primary key for the mapping';
comment on column swrs.naics_category.naics_category is 'The naics category';


create table swrs.naics_naics_category (
  id integer generated always as identity primary key,
  naics_code_pattern varchar(1000),
  category_id integer,
  category_type_id integer
);

comment on table  swrs.naics_naics_category is 'The fuel mapping table that maps naics codes with hhw and irc categories';
comment on column swrs.naics_naics_category.id is 'The internal primary key for the mapping';
comment on column swrs.naics_naics_category.naics_code_pattern is 'The naics code pattern';
comment on column swrs.naics_naics_category.category_id is 'The foreign key for the category';
comment on column swrs.naics_naics_category.category_type_id is 'The foreign key for the category type';



create table swrs.taxed_venting_emission_type (
  id integer primary key generated always as identity,
  taxed_emission_type varchar(1000)
);

comment on table swrs.taxed_venting_emission_type is 'Table of emission types that are carbon taxed in relation to venting as per https://www.bclaws.gov.bc.ca/civix/document/id/complete/statreg/249_2015#ScheduleA';
comment on column swrs.taxed_venting_emission_type.id is 'Unique ID for the taxed_venting_emission_type table';
comment on column swrs.taxed_venting_emission_type.taxed_emission_type is 'The name of the carbon taxed emission type';

commit;
