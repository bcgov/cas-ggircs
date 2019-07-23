-- Verify ggircs:table_activity on pg

begin;

select pg_catalog.has_table_privilege('swrs.activity', 'select');

rollback;
