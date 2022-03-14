-- Deploy ggircs:swrs/parameters/types/umapped_fuel_return_type to pg

begin;

create type ggircs_parameters.unmapped_fuel_return as(
  fuel_type text,
  fuel_mapping_id int
);

commit;
