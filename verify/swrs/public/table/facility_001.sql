-- Verify ggircs:swrs/public/table/facility_001 on pg

begin;

select pg_catalog.has_table_privilege('swrs.facility', 'select');

rollback;
