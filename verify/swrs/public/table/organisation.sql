-- Verify ggircs:table_organisation on pg

begin;

select pg_catalog.has_table_privilege('swrs.organisation', 'select');

rollback;
