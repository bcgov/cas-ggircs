-- Verify swrs_transform:table_ghgr_import on pg

begin;

select pg_catalog.has_table_privilege('swrs_extract.ghgr_import', 'select');

rollback;
