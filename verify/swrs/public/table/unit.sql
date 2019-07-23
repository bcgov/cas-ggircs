-- Verify ggircs:table_unit on pg

begin;

select pg_catalog.has_table_privilege('swrs.unit', 'select');

rollback;
