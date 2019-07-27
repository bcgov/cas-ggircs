-- Verify ggircs:table_naics on pg

begin;

select pg_catalog.has_table_privilege('swrs.naics', 'select');

rollback;
