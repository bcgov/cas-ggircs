-- Deploy ggircs:swrs/public/view/carbon_tax_act_fuel_type to pg
-- requires: swrs/parameters/table/carbon_tax_act_fuel_type

begin;

create or replace view swrs.carbon_tax_act_fuel_type as (
  select * from ggircs_parameters.carbon_tax_act_fuel_type
);

comment on view swrs.carbon_tax_act_fuel_type is 'A view that retrieves the data from the ggircs_parameters.carbon_tax_act_fuel_type table. This view is necessary to maintain relationships defined elsewhere like CIIP and metabase after the table was moved to the ggircs_parameters schema';
comment on column swrs.carbon_tax_act_fuel_type.id is 'The internal primary key';
comment on column swrs.carbon_tax_act_fuel_type.carbon_tax_fuel_type is 'Fuel type defined by the carbon tax act';

commit;
