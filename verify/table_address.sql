-- Verify ggircs:table_address on pg

begin;

select pg_catalog.has_table_privilege('ggircs.address', 'select');

rollback;
