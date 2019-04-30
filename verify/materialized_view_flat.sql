-- Verify ggircs:materialized_view_flat on pg

BEGIN;

select * from ggircs_swrs.flat where false;

ROLLBACK;
