-- Verify ggircs-portal:tables/emission_factor on pg

begin;

select pg_catalog.has_table_privilege('swrs.emission_factor', 'select');

rollback;