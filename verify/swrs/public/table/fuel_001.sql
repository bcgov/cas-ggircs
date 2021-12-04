-- Verify ggircs:swrs/public/table/fuel_001 on pg

begin;

select pg_catalog.has_table_privilege('swrs.fuel', 'select');

rollback;
