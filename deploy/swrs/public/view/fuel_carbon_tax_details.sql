-- Deploy ggircs:swrs/public/view/fuel_carbon_tax_details to pg
-- requires: swrs/parameters/table/fuel_carbon_tax_detail

begin;

create or replace view swrs.fuel_carbon_tax_details as (
  select * from ggircs_parameters.fuel_carbon_tax_detail
);

comment on view swrs.fuel_carbon_tax_details is 'A view that retrieves the data from the ggircs_parameters.fuel_carbon_tax_detail table. This view is necessary to maintain relationships defined elsewhere like CIIP and metabase after the table was moved to the ggircs_parameters schema';
comment on column swrs.fuel_carbon_tax_details.id is 'The internal primary key for the mapping';
comment on column swrs.fuel_carbon_tax_details.carbon_tax_act_fuel_type_id is 'The foreign key that maps to the carbon_tax_act_fuel_type table';
comment on column swrs.fuel_carbon_tax_details.normalized_fuel_type is 'The type of fuel (Normalized)';
comment on column swrs.fuel_carbon_tax_details.state is 'The state of the fuel (gas, liquid, solid)';
comment on column swrs.fuel_carbon_tax_details.cta_rate_units is 'The units of measure';
comment on column swrs.fuel_carbon_tax_details.unit_conversion_factor is 'The conversion factor for cta units to reported units';

commit;
