-- Verify ggircs:swrs/public/table/emission_001 on pg

begin;

select pg_catalog.has_table_privilege('swrs.emission', 'select');

rollback;
