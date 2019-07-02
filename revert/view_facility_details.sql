-- Revert ggircs:view_facility_details from pg

BEGIN;

drop view if exists ggircs.facility_details;

COMMIT;
