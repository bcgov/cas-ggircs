-- Revert ggircs:swrs/parameters/table/carbon_tax_act_fuel_type_001 from pg

begin;

alter table ggircs_parameters.carbon_tax_act_fuel_type drop column cta_rate_units;
alter table ggircs_parameters.carbon_tax_act_fuel_type drop column metadata;

delete from ggircs_parameters.carbon_tax_act_fuel_type where carbon_tax_fuel_type = 'Combustible Waste';

commit;
