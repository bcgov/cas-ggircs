-- Revert ggircs:table_fuel_carbon_tax_details from pg

BEGIN;

drop table ggircs_swrs.fuel_carbon_tax_details;

COMMIT;
