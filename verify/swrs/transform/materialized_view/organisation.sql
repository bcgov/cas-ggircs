-- Verify ggircs:materialized_view_organisation on pg

BEGIN;

select * from swrs_transform.organisation where false;
--  select false from pg_matviews where schemaname = 'swrs_transform' and matviewname = 'organisation';

ROLLBACK;
