-- Verify ggircs_swrs:table_ghgr_import on pg

begin;

select pg_catalog.has_table_privilege('ggircs_swrs.ghgr_import', 'select');

rollback;
