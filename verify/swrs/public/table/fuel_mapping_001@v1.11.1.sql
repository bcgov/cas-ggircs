-- Verify ggircs:swrs/public/table/fuel_mapping_001 on pg

begin;

select pg_catalog.has_table_privilege('swrs.fuel_mapping', 'select');

rollback;
