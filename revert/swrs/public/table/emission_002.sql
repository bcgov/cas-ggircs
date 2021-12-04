-- Revert ggircs:swrs/public/table/emission_002 from pg

begin;

drop index if exists swrs.emission_fuel_mapping_foreign_key;

commit;
