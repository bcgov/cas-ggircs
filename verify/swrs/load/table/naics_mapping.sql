-- Verify ggircs:table_naics_mapping on pg

begin;

select pg_catalog.has_table_privilege('ggircs_swrs_load.naics_mapping', 'select');

rollback;
