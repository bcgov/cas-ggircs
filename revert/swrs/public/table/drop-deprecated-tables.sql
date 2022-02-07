-- Revert ggircs:swrs/public/table/drop-deprecated-tables from pg

begin;

-- CARBON_TAX_RATE_MAPPING
create table swrs.carbon_tax_rate_mapping (
  id integer generated always as identity primary key,
  rate_start_date date,
  rate_end_date date,
  carbon_tax_rate numeric

);
comment on table  swrs.carbon_tax_rate_mapping is 'DEPRECATED The carbon tax rate table that maps date with carbon tax rates';
comment on column swrs.carbon_tax_rate_mapping.id is 'The internal primary key for the mapping';
comment on column swrs.carbon_tax_rate_mapping.rate_start_date is 'The date that the tax rate begins to apply';
comment on column swrs.carbon_tax_rate_mapping.rate_end_date is 'The date that the tax rate stops applying';
comment on column swrs.carbon_tax_rate_mapping.carbon_tax_rate is 'The carbon tax rate for the date range';

-- IMPLIED_EMISSION_FACTOR
create table swrs.implied_emission_factor (
  id integer generated always as identity primary key,
  implied_emission_factor numeric,
  start_date date,
  end_date date,
  fuel_mapping_id integer references swrs.fuel_mapping(id)
);

create index ggircs_swrs_implied_emission_factor_fuel_mapping_foreign_key on swrs.implied_emission_factor(fuel_mapping_id);

comment on table  swrs.implied_emission_factor is 'DEPRECATED The implied emission factor table contains the implied factor to be multiplied by the carbon tax rate for each fuel';
comment on column swrs.implied_emission_factor.id is 'The internal primary key';
comment on column swrs.implied_emission_factor.implied_emission_factor is 'The ministry-defined implied emission factor pertaining to a specific fuel type';
comment on column swrs.implied_emission_factor.start_date is 'The date on which the implied emission factor came into effect';
comment on column swrs.implied_emission_factor.end_date is 'The date on which the implied emission factor stops/stopped being used';
comment on column swrs.implied_emission_factor.fuel_mapping_id is 'The foreign key reference to the fuel mapping table';


-- NAICS_CATEGORY_TYPE
create table swrs.naics_category_type (
  id integer generated always as identity primary key,
  naics_category_type varchar(1000),
  description varchar(1000)
);

comment on table  swrs.naics_category_type is 'The fuel mapping table that maps naics codes with hhw and irc categories';
comment on column swrs.naics_category_type.id is 'The internal primary key for the type mapping';
comment on column swrs.naics_category_type.naics_category_type is 'The naics category type';
comment on column swrs.naics_category_type.description is 'The description of the category type';

-- NAICS_MAPPING
create table swrs.naics_mapping (
  id integer generated always as identity primary key,
  naics_code integer,
  hhw_category varchar(1000),
  irc_category varchar(1000)
);

comment on table  swrs.naics_mapping is 'The fuel mapping table that maps naics codes with hhw and irc categories';
comment on column swrs.naics_mapping.id is 'The internal primary key for the mapping';
comment on column swrs.naics_mapping.naics_code is 'The naics code';
comment on column swrs.naics_mapping.hhw_category is 'The higher level (hhw) category definition';
comment on column swrs.naics_mapping.irc_category is 'The lower level irc category definition';

commit;
