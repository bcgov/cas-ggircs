-- Verify ggircs:ciip_table_facility on pg

begin;

select pg_catalog.has_table_privilege('ciip_2018.facility', 'select');

rollback;

