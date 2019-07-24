-- Deploy ggircs:table_implied_emission_factor to pg
-- requires: schema_ggircs_swrs

begin;

create table swrs.implied_emission_factor (
  id integer generated always as identity primary key,
  implied_emission_factor numeric,
  start_date date,
  end_date date,
  fuel_mapping_id integer references swrs.fuel_mapping(id)
);

create index ggircs_swrs_implied_emission_factor_fuel_mapping_foreign_key on swrs.implied_emission_factor(fuel_mapping_id);

comment on table  swrs.implied_emission_factor is 'DEPRECATED The implied emission factor table contains the implied factor to be multiplied by the carbon tax rate for each fuel';
comment on column swrs.implied_emission_factor.id is 'The internal primary key';
comment on column swrs.implied_emission_factor.implied_emission_factor is 'The ministry-defined implied emission factor pertaining to a specific fuel type';
comment on column swrs.implied_emission_factor.start_date is 'The date on which the implied emission factor came into effect';
comment on column swrs.implied_emission_factor.end_date is 'The date on which the implied emission factor stops/stopped being used';
comment on column swrs.implied_emission_factor.fuel_mapping_id is 'The foreign key reference to the fuel mapping table';

commit;
