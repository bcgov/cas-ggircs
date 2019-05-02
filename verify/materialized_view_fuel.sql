-- Verify ggircs:materialized_view_fuel on pg

BEGIN;

select * from ggircs_swrs.fuel where false;

ROLLBACK;
