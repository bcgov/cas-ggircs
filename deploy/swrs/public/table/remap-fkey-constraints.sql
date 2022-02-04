-- Deploy ggircs:swrs/public/table/remap-fkey-constraints to pg
-- requires: swrs/utility/table/fuel_mapping
-- requires: swrs/utility/table/emission_category
-- requires: swrs/utility/table/fuel_charge

begin;

  -- SWRS.EMISSION
  -- drop the old fkey constraint on swrs.emission
  alter table swrs.emission drop constraint emission_fuel_mapping_id_fkey;
  -- create the new fkey constraint
  alter table swrs.emission add constraint emission_fuel_mapping_id_fkey foreign key (fuel_mapping_id) references swrs_utility.fuel_mapping(id);
  create index if not exists emission_utility_fuel_mapping_fkey on swrs.emission(fuel_mapping_id);


  -- SWRS.FUEL
  -- drop the old fkey constraint on swrs.fuel
  alter table swrs.fuel drop constraint fuel_fuel_mapping_id_fkey;
  -- create the new fkey constraint
  alter table swrs.fuel add constraint fuel_fuel_mapping_id_fkey foreign key (fuel_mapping_id) references swrs_utility.fuel_mapping(id);
  create index if not exists fuel_utility_fuel_mapping_fkey on swrs.fuel(fuel_mapping_id);

commit;
