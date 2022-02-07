-- Deploy ggircs:swrs/public/table/fuel_carbon_tax_details_001 to pg
-- requires: swrs/public/table/fuel_carbon_tax_details
-- requires: swrs/public/table/carbon_tax_act_fuel_type

begin;

/**
    do nothing
    this rework is intended to ignore verification of the old non-idempotent change for this table which was dropped in
    the migration 'drop-non-etl-tables'.
**/

commit;
