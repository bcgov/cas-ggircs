-- Verify ggircs:table_descriptor on pg

begin;

select pg_catalog.has_table_privilege('ggircs.descriptor', 'select');

rollback;
