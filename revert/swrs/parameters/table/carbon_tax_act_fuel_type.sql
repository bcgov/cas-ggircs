-- Revert ggircs:swrs/parameters/table/carbon_tax_act_fuel_type from pg

begin;

drop table ggircs_parameters.carbon_tax_act_fuel_type;

commit;
