-- Verify ggircs:table_ghgr_import on pg

BEGIN;

select pg_catalog.has_table_privilege('ggircs_swrs.ghgr_import', 'select');

ROLLBACK;
