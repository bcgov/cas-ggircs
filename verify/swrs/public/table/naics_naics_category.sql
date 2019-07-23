-- Verify ggircs_swrs:table_naics_naics_category on pg

begin;

select pg_catalog.has_table_privilege('swrs.naics_naics_category', 'select');

rollback;
