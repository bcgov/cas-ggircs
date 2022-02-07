-- Verify ggircs:swrs/public/table/fuel_charge_003 on pg

begin;

select pg_catalog.has_table_privilege('swrs.fuel_charge', 'select');

rollback;
