-- Verify ggircs:table_naics_mapping on pg

begin;

select pg_catalog.has_table_privilege('swrs.naics_mapping', 'select');

rollback;
