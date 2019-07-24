-- Deploy ggircs:table_fuel_charge to pg
-- requires: schema_ggircs_swrs

begin;

create table swrs.fuel_charge (
  id integer generated always as identity primary key,
  fuel_charge numeric,
  start_date date,
  end_date date,
  fuel_mapping_id integer references swrs.fuel_mapping(id)
);

create index ggircs_swrs_fuel_charge_fuel_mapping_foreign_key on swrs.fuel_charge(fuel_mapping_id);

comment on table  swrs.fuel_charge is 'The fuel charge table contains the carbon tax fuel charge rate band for each fuel';
comment on column swrs.fuel_charge.id is 'The internal primary key';
comment on column swrs.fuel_charge.fuel_charge is 'The ministry-defined fuel charge pertaining to a specific fuel type';
comment on column swrs.fuel_charge.start_date is 'The date on which the fuel charge rate band came into effect';
comment on column swrs.fuel_charge.end_date is 'The date on which the fuel charge rate band stops/stopped being used';
comment on column swrs.fuel_charge.fuel_mapping_id is 'The foreign key reference to the fuel mapping table';

commit;
