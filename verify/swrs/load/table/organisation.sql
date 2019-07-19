-- Verify ggircs:table_organisation on pg

begin;

select pg_catalog.has_table_privilege('ggircs_swrs_load.organisation', 'select');

rollback;
