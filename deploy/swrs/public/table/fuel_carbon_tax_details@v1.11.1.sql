-- Deploy ggircs:table_fuel_carbon_tax_details to pg
-- requires: schema_ggircs_swrs

-- Deploy ggircs:table_fuel_carbon_tax_details to pg
-- requires: schema_ggircs_swrs

begin;

create table swrs.fuel_carbon_tax_details (
  id integer generated always as identity primary key,
  normalized_fuel_type varchar(1000),
  state varchar(1000),
  carbon_taxed boolean,
  cta_mapping varchar(1000),
  cta_rate_units varchar(1000),
  unit_conversion_factor integer

);

comment on table  swrs.fuel_carbon_tax_details is 'The fuel mapping table that maps fuel type with carbon tax rates';
comment on column swrs.fuel_carbon_tax_details.id is 'The internal primary key for the mapping';
comment on column swrs.fuel_carbon_tax_details.normalized_fuel_type is 'The type of fuel (Normalized)';
comment on column swrs.fuel_carbon_tax_details.state is 'The state of the fuel (gas, liquid, solid)';
comment on column swrs.fuel_carbon_tax_details.carbon_taxed is 'Is the fuel carbon taxed';
comment on column swrs.fuel_carbon_tax_details.cta_mapping is 'Generalized high-level fuel type';
comment on column swrs.fuel_carbon_tax_details.cta_rate_units is 'The units of measure';
comment on column swrs.fuel_carbon_tax_details.unit_conversion_factor is 'The conversion factor for cta units to reported units';

commit;
