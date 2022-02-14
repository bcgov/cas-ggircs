-- Revert ggircs:swrs/public/table/remap-fkey-constraints from pg

BEGIN;

  -- SWRS.EMISSION
  alter table swrs.emission drop constraint emission_fuel_mapping_id_fkey;
  alter table swrs.emission add constraint emission_fuel_mapping_id_fkey foreign key (fuel_mapping_id) references swrs.fuel_mapping(id);
  drop index if exists emission_parameters_fuel_mapping_fkey;


  -- SWRS.FUEL
  -- drop the old fkey constraint on swrs.fuel
  alter table swrs.fuel drop constraint fuel_fuel_mapping_id_fkey;
  -- create the new fkey constraint
  alter table swrs.fuel add constraint fuel_fuel_mapping_id_fkey foreign key (fuel_mapping_id) references swrs.fuel_mapping(id);
  drop index if exists fuel_parameters_fuel_mapping_fkey;

COMMIT;
