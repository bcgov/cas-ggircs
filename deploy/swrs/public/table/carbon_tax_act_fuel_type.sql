-- Deploy ggircs:swrs/public/table/carbon_tax_act_fuel_type to pg
-- requires: swrs/public/schema

begin;

create table swrs.carbon_tax_act_fuel_type (
  id integer generated always as identity primary key,
  carbon_tax_fuel_type varchar(1000)
);

comment on table  swrs.carbon_tax_act_fuel_type is 'Table contains the list of fuels as defined by the carbon tax act https://www.bclaws.gov.bc.ca/civix/document/id/complete/statreg/08040_01';
comment on column swrs.carbon_tax_act_fuel_type.id is 'The internal primary key';
comment on column swrs.carbon_tax_act_fuel_type.carbon_tax_fuel_type is 'Fuel type defined by the carbon tax act';

commit;
