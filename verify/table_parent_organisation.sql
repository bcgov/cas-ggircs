-- Verify ggircs:table_parent_organisation on pg

begin;

select pg_catalog.has_table_privilege('ggircs.parent_organisation', 'select');

rollback;
