-- Verify ggircs:swrs/parameters/table/fuel_mapping on pg

begin;

select pg_catalog.has_table_privilege('ggircs_parameters.fuel_mapping', 'select');

rollback;
