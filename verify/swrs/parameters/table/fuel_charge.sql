-- Verify ggircs:swrs/parameters/table/fuel_charge on pg

begin;

select pg_catalog.has_table_privilege('ggircs_parameters.fuel_charge', 'select');

rollback;
