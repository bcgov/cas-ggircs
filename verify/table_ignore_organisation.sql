-- Verify ggircs_swrs:table_ignore_organisation on pg

begin;

select pg_catalog.has_table_privilege('ggircs_swrs.table_ignore_organisation', 'select');

rollback;
