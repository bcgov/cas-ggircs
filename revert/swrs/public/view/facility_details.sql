-- Revert ggircs:view_facility_details from pg

BEGIN;

drop view if exists swrs.facility_details;

COMMIT;
