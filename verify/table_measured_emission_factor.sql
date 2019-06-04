-- Verify ggircs:table_measured_emission_factor on pg

begin;

select pg_catalog.has_table_privilege('ggircs.measured_emission_factor', 'select');

rollback;
