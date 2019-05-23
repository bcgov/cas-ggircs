-- Deploy ggircs:table_fuel_mapping to pg
-- requires: schema_ggircs_swrs

begin;

create table ggircs_swrs.fuel_mapping (
  id integer generated always as identity primary key,
  fuel_type varchar(1000),
  n_fuel_type varchar(1000),
  state varchar(1000),
  carbon_taxed varchar(1000),
  cta_mapping varchar(1000),
  cta_rate_30_tCO2e numeric,
  cta_rate_35_tCO2e numeric,
  cta_rate_40_tCO2e numeric,
  cta_rate_45_tCO2e numeric,
  cta_rate_50_tCO2e numeric,
  cta_rate_units varchar

);
comment on table  ggircs_swrs.fuel_mapping is 'The fuel mapping table that maps fuel type with carbon tax rates';
comment on column ggircs_swrs.fuel_mapping.id is 'The internal primary key for the mapping';
comment on column ggircs_swrs.fuel_mapping.fuel_type is 'The type of fuel';
comment on column ggircs_swrs.fuel_mapping.n_fuel_type is 'The type of fuel';
comment on column ggircs_swrs.fuel_mapping.state is 'The state of the fuel (gas, liquid, solid)';
comment on column ggircs_swrs.fuel_mapping.carbon_taxed is 'Is the fuel carbon taxed';
comment on column ggircs_swrs.fuel_mapping.cta_mapping is 'What maps this fuel to the carbon tax';
comment on column ggircs_swrs.fuel_mapping.cta_rate_30_tCO2e is 'CTA rate at $30/tCO2e';
comment on column ggircs_swrs.fuel_mapping.cta_rate_35_tCO2e is 'CTA rate at $35/tCO2e';
comment on column ggircs_swrs.fuel_mapping.cta_rate_40_tCO2e is 'CTA rate at $40/tCO2e';
comment on column ggircs_swrs.fuel_mapping.cta_rate_45_tCO2e is 'CTA rate at $45/tCO2e';
comment on column ggircs_swrs.fuel_mapping.cta_rate_50_tCO2e is 'CTA rate at $50/tCO2e';
comment on column ggircs_swrs.fuel_mapping.cta_rate_units is 'The units of measure';

commit;
