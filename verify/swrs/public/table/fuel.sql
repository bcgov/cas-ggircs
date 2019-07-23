-- Verify ggircs:table_fuel on pg

begin;

select pg_catalog.has_table_privilege('swrs.fuel', 'select');

rollback;
