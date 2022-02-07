-- Deploy ggircs:table_fuel_carbon_tax_details to pg
-- requires: schema_ggircs_swrs

-- Deploy ggircs:table_fuel_carbon_tax_details to pg
-- requires: schema_ggircs_swrs

begin;

/**
    do nothing
    this rework is intended to ignore verification of the old non-idempotent change for this table which was dropped in
    the migration 'drop-non-etl-tables'.
**/

commit;
