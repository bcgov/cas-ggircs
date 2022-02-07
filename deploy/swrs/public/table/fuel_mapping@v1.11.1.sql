-- Deploy ggircs:table_fuel_mapping to pg
-- requires: schema_ggircs_swrs

begin;

create table swrs.fuel_mapping (
  id integer generated always as identity primary key,
  fuel_type varchar(1000),
  fuel_carbon_tax_details_id integer

);

comment on table  swrs.fuel_mapping is 'DEPRECATED The fuel mapping table that maps fuel type with carbon tax rates';
comment on column swrs.fuel_mapping.id is 'The internal primary key for the mapping';
comment on column swrs.fuel_mapping.fuel_type is 'The type of fuel (from GHGR), Foreign key to fuel';
comment on column swrs.fuel_mapping.fuel_carbon_tax_details_id is 'The foreign key to swrs.fuel_carbon_tax_details';


create unique index ggircs_swrs_fuel_mapping_fuel_type on swrs.fuel_mapping(fuel_type);

commit;
