-- Revert ggircs:swrs/parameters/table/fuel_carbon_tax_detail from pg

begin;

drop table ggircs_parameters.fuel_carbon_tax_detail;

commit;
