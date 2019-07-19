-- Verify ggircs:materialized_view_activity on pg

BEGIN;

select * from ggircs_swrs_transform.activity where false;

ROLLBACK;
