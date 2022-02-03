-- Revert ggircs:swrs/utility/table/fuel_carbon_tax_detail from pg

begin;

drop table swrs_utility.fuel_carbon_tax_detail;

commit;
