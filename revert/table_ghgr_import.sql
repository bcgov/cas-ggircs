-- Revert ggircs:table_ghgr_import from pg

BEGIN;

drop table ggircs_swrs.ghgr_import;

COMMIT;
