-- Verify ggircs:materialized_view_flat on pg

BEGIN;

select * from ggircs_swrs_transform.flat where false;

ROLLBACK;
