-- Verify ggircs:table_identifier on pg

begin;

select pg_catalog.has_table_privilege('ggircs_swrs_load.identifier', 'select');

rollback;
