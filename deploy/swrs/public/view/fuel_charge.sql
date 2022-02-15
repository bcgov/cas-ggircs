-- Deploy ggircs:swrs/public/view/fuel_charge to pg
-- requires: swrs/parameters/table/fuel_charge

begin;

create or replace view swrs.fuel_charge as (
  select * from ggircs_parameters.fuel_charge
);

comment on view swrs.fuel_charge is 'A view that retrieves the data from the ggircs_parameters.fuel_charge table. This view is necessary to maintain relationships defined elsewhere like CIIP and metabase after the table was moved to the ggircs_parameters schema';
comment on column swrs.fuel_charge.id is 'The internal primary key';
comment on column swrs.fuel_charge.carbon_tax_act_fuel_type_id is 'Foreign key references the carbon_tax_act_fuel_type table';
comment on column swrs.fuel_charge.fuel_charge is 'The ministry-defined fuel charge pertaining to a specific fuel type';
comment on column swrs.fuel_charge.start_date is 'The date on which the fuel charge rate band came into effect';
comment on column swrs.fuel_charge.end_date is 'The date on which the fuel charge rate band stops/stopped being used';
comment on column swrs.fuel_charge.metadata is 'Column contains metadata pertaining to each fuel charge row';

commit;
