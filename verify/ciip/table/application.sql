-- Verify ggircs:ciip_table_application on pg

begin;

select pg_catalog.has_table_privilege('ciip_2018.application', 'select');

rollback;
