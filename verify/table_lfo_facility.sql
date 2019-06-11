-- Verify ggircs:table_lfo_facility on pg

BEGIN;

select pg_catalog.has_table_privilege('ggircs.lfo_facility', 'select');

ROLLBACK;
