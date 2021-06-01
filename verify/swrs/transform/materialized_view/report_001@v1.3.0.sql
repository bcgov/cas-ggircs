-- Verify ggircs:swrs/transform/materialized_view/report_001 on pg

begin;

-- selecting from the matview will throw an error if it doesn't exist
-- but there's no need to return any value so select where false
select * from swrs_transform.report where false;
--  select false from pg_matviews where schemaname = 'swrs_transform' and matviewname = 'report';

rollback;
