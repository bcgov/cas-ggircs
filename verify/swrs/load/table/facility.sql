-- Verify ggircs:table_facility on pg

begin;

select pg_catalog.has_table_privilege('ggircs_swrs_load.facility', 'select');

rollback;
