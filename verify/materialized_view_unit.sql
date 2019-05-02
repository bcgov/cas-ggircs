-- Verify ggircs:materialized_view_unit on pg

BEGIN;

select * from ggircs_swrs.unit where false;

ROLLBACK;
