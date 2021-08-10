-- Revert ggircs:swrs/history/schema from pg

BEGIN;

drop schema swrs_history;

COMMIT;
