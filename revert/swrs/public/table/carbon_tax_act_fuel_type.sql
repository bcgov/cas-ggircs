-- Revert ggircs:swrs/public/table/carbon_tax_act_fuel_type from pg

begin;

drop table swrs.carbon_tax_rate_mapping;

commit;
