-- Verify ggircs:table_carbon_tax_rate_mapping on pg

begin;

/**
    do nothing
    this rework is intended to ignore verification of the old non-idempotent change for this table which was dropped in
    the migration 'drop-non-etl-tables'.
**/

rollback;
