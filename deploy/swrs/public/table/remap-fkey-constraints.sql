-- Deploy ggircs:swrs/public/table/remap-fkey-constraints to pg
-- requires: swrs/parameters/table/fuel_mapping
-- requires: swrs/parameters/table/emission_category
-- requires: swrs/parameters/table/fuel_charge

begin;

  -- SWRS.EMISSION
  -- drop the old fkey constraint on swrs.emission
  alter table swrs.emission drop constraint emission_fuel_mapping_id_fkey;
  -- create the new fkey constraint
  alter table swrs.emission add constraint emission_fuel_mapping_id_fkey foreign key (fuel_mapping_id) references ggircs_parameters.fuel_mapping(id);
  create index if not exists emission_parameters_fuel_mapping_fkey on swrs.emission(fuel_mapping_id);


  -- SWRS.FUEL
  -- drop the old fkey constraint on swrs.fuel
  alter table swrs.fuel drop constraint fuel_fuel_mapping_id_fkey;
  -- create the new fkey constraint
  alter table swrs.fuel add constraint fuel_fuel_mapping_id_fkey foreign key (fuel_mapping_id) references ggircs_parameters.fuel_mapping(id);
  create index if not exists fuel_parameters_fuel_mapping_fkey on swrs.fuel(fuel_mapping_id);

commit;
