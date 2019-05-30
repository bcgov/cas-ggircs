-- Verify ggircs:table_naics_mapping on pg

begin;

select pg_catalog.has_table_privilege('ggircs_swrs.naics_mapping', 'select');

rollback;
