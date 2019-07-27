-- Verify ggircs:table_implied_emission_factor on pg

begin;

select pg_catalog.has_table_privilege('swrs.implied_emission_factor', 'select');

rollback;
