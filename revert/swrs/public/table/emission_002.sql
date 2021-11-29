-- Revert ggircs:swrs/public/table/emission_002 from pg

begin;

drop index swrs.ggircs_emission_fuel_mapping_foreign_key;

commit;
