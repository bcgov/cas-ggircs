-- Revert ggircs:swrs/utility/table/carbon_tax_act_fuel_type from pg

begin;

drop table swrs_utility.carbon_tax_act_fuel_type;

commit;
