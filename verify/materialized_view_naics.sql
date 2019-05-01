-- Verify ggircs:materialized_view_naics on pg

BEGIN;

select * from ggircs_swrs.naics where false;

ROLLBACK;
