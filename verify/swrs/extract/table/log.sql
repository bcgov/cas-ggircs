-- Verify ggircs:table_log on pg

begin;

select pg_catalog.has_table_privilege('swrs_extract.log', 'select');

rollback;
