-- Deploy ggircs:swrs/public/table/fuel_001 to pg
-- requires: swrs/public/table/fuel

begin;

alter table swrs.fuel add column emission_category varchar(1000);
create index swrs_fuel_emission_category on swrs.fuel(emission_category);

comment on column swrs.fuel.emission_category is 'The emission category the reported fuel belongs to';

commit;
