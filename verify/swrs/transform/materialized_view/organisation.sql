-- Verify ggircs:materialized_view_organisation on pg

BEGIN;

select * from ggircs_swrs_transform.organisation where false;
--  select false from pg_matviews where schemaname = 'ggircs_swrs' and matviewname = 'organisation';

ROLLBACK;
