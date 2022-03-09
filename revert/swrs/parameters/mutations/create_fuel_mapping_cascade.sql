-- Revert ggircs:swrs/parameters/mutations/create_fuel_mapping_cascade from pg

begin;

drop function ggircs_parameters.create_fuel_mapping_cascade();

commit;
