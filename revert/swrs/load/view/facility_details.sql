-- Revert ggircs:view_facility_details from pg

BEGIN;

drop view if exists ggircs_swrs_load.facility_details;

COMMIT;
