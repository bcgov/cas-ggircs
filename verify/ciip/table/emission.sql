-- Verify ggircs:ciip_table_emission on pg

begin;

select pg_catalog.has_table_privilege('ciip_2018.emission', 'select');

rollback;
