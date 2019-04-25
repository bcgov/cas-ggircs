-- Verify ggircs:materialized_view_report on pg

BEGIN;

select * from pg_matviews where matviewname='report';

ROLLBACK;
