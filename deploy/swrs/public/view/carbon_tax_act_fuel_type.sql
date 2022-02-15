-- Deploy ggircs:swrs/public/view/carbon_tax_act_fuel_type to pg
-- requires: swrs/parameters/table/carbon_tax_act_fuel_type

begin;

create or replace view swrs.carbon_tax_act_fuel_type as (
  select * from ggircs_parameters.carbon_tax_act_fuel_type
);

commit;
