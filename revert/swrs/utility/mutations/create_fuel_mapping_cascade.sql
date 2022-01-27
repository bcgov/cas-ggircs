-- Revert ggircs:swrs/utility/mutations/create_fuel_mapping_cascade from pg

begin;

drop function if exists swrs_utility.create_fuel_mapping_cascade;

commit;
