-- Verify ggircs:materialized_view_organisation on pg

BEGIN;

select * from ggircs_swrs.organisation where false;

ROLLBACK;
