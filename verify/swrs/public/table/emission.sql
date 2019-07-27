-- Verify ggircs:table_emission on pg

begin;

select pg_catalog.has_table_privilege('swrs.emission', 'select');

rollback;
