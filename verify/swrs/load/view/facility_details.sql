-- Verify ggircs:view_facility_details on pg

BEGIN;

select * from ggircs_swrs_load.facility_details where false;

ROLLBACK;
