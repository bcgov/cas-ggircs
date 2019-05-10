-- Verify ggircs:materialized_view_descriptors on pg

BEGIN;

select * from ggircs_swrs.descriptor where false;

ROLLBACK;
