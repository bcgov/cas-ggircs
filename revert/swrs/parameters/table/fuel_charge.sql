-- Revert ggircs:swrs/parameters/table/fuel_charge from pg

begin;

drop table ggircs_parameters.fuel_charge;

commit;
