-- Deploy ggircs:swrs/public/table/fuel_mapping_001 to pg
-- requires: swrs/public/table/fuel_mapping

begin;

/**
    do nothing
    this rework is intended to ignore verification of the old non-idempotent change for this table which was dropped in
    the migration 'drop-non-etl-tables'.
**/

commit;
