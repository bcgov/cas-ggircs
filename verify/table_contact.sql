-- Verify ggircs:table_contact on pg

begin;

select pg_catalog.has_table_privilege('ggircs.contact', 'select');

rollback;
