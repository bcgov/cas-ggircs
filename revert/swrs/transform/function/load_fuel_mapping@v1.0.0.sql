-- Revert ggircs:swrs/transform/function/load_fuel_mapping from pg

begin;

drop function swrs_transform.load_fuel_mapping;

commit;
