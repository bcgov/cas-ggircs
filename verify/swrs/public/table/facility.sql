-- Verify ggircs:table_facility on pg

begin;

select pg_catalog.has_table_privilege('swrs.facility', 'select');

rollback;
