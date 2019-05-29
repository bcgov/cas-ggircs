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
  co2e_conversion_rate numeric,
  cta_rate_units varchar(1000)

);
comment on table  ggircs_swrs.fuel_mapping is 'The fuel mapping table that maps fuel type with carbon tax rates';
comment on column ggircs_swrs.fuel_mapping.id is 'The internal primary key for the mapping';
comment on column ggircs_swrs.fuel_mapping.fuel_type is 'The type of fuel (from GHGR), Foreign key to fuel';
comment on column ggircs_swrs.fuel_mapping.normalized_fuel_type is 'The type of fuel (Normalized)';
comment on column ggircs_swrs.fuel_mapping.state is 'The state of the fuel (gas, liquid, solid)';
comment on column ggircs_swrs.fuel_mapping.carbon_taxed is 'Is the fuel carbon taxed';
comment on column ggircs_swrs.fuel_mapping.cta_mapping is 'Generalized high-level fuel type';
comment on column ggircs_swrs.fuel_mapping.co2e_conversion_rate is 'The conversion rate of the fuel to co2e';
comment on column ggircs_swrs.fuel_mapping.cta_rate_units is 'The units of measure';

copy ggircs_swrs.fuel_mapping(fuel_type, normalized_fuel_type,state, carbon_taxed, cta_mapping, co2e_conversion_rate, cta_rate_units) from '/home/dleard/Button/cas-ggircs/data/fuel_mapping_remix.csv' with (format csv);

commit;
