-- Verify ggircs:table_naics on pg

begin;

select pg_catalog.has_table_privilege('ggircs_swrs_load.naics', 'select');

rollback;
