-- Revert ggircs:table_fuel_carbon_tax_details from pg

BEGIN;

drop table ggircs.fuel_carbon_tax_details;

COMMIT;
