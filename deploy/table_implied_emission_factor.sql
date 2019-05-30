-- Deploy ggircs:table_implied_emission_factor to pg
-- requires: schema_ggircs_swrs

begin;

create table ggircs_swrs.implied_emission_factor (
  id integer generated always as identity primary key,
  fuel_type varchar(1000),
  implied_emission_factor numeric,
  start_date date,
  end_date date

);

commit;