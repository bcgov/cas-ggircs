-- Verify ggircs_swrs:table_naics_naics_category on pg

begin;

select pg_catalog.has_table_privilege('ggircs.naics_naics_category', 'select');

rollback;
