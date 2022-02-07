-- Deploy ggircs:swrs/public/table/carbon_tax_act_fuel_type to pg
-- requires: swrs/public/schema

begin;

/**
    do nothing
    this rework is intended to ignore verification of the old non-idempotent change for this table which was dropped in
    the migration 'drop-non-etl-tables'.
**/

commit;
