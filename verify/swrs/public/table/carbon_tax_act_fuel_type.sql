-- Verify ggircs:swrs/public/table/carbon_tax_act_fuel_type on pg

begin;

/**
    do nothing
    this rework is intended to ignore verification of the old non-idempotent change for this table which was dropped in
    the migration 'drop-non-etl-tables'.
**/

rollback;
