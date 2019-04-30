-- Verify ggircs:materialized_view_identifier on pg

BEGIN;

select * from ggircs_swrs.identifier where false;

ROLLBACK;
