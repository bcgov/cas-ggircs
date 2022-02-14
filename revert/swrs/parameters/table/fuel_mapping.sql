-- Revert ggircs:swrs/parameters/table/fuel_mapping from pg

begin;

drop table ggircs_parameters.fuel_mapping;

commit;
