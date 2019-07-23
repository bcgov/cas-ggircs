-- Verify ggircs:ciip_table_address on pg

begin;

select pg_catalog.has_table_privilege('ciip_2018.address', 'select');

rollback;
