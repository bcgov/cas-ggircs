-- Verify ggircs:materialized_view_report on pg

begin;

-- selecting from the matview will throw an error if it doesn't exist
-- but there's no need to return any value so select where false
select * from ggircs_swrs.report where false;
--  select false from pg_matviews where schemaname = 'ggircs_swrs' and matviewname = 'report';

rollback;
