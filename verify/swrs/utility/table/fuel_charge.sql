-- Verify ggircs:swrs/utility/table/fuel_charge on pg

begin;

select pg_catalog.has_table_privilege('swrs_utility.fuel_charge', 'select');

rollback;
