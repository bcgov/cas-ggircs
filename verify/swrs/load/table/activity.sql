-- Verify ggircs:table_activity on pg

begin;

select pg_catalog.has_table_privilege('ggircs_swrs_load.activity', 'select');

rollback;
