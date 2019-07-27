-- Verify ggircs:ciip_table_operator on pg

begin;

select pg_catalog.has_table_privilege('ciip_2018.operator', 'select');

rollback;
