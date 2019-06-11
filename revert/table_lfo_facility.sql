-- Revert ggircs:table_lfo_facility from pg

BEGIN;

drop table ggircs.lfo_facility;

COMMIT;
