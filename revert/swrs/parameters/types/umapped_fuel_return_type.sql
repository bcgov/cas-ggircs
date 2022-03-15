-- Revert ggircs:swrs/parameters/types/umapped_fuel_return_type from pg

begin;

drop type ggircs_parameters.unmapped_fuel_return;

commit;
