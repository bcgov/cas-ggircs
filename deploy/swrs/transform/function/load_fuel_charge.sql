-- Deploy ggircs:swrs/transform/function/load_fuel_charge to pg
-- requires: swrs/transform/schema
-- requires: swrs/public/table/fuel_charge

begin;

drop function swrs_transform.load_fuel_charge;

commit;
