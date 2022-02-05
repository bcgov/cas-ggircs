-- Deploy ggircs:swrs/transform/function/load_fuel_mapping to pg
-- requires: swrs/transform/schema
-- requires: swrs/public/table/fuel_mapping

begin;

drop function swrs_transform.load_fuel_mapping;

commit;
