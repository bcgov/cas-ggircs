-- Verify ggircs:swrs/utility/table/fuel_mapping on pg

begin;

select pg_catalog.has_table_privilege('swrs_utility.fuel_mapping', 'select');

rollback;
