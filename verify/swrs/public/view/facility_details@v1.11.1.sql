-- Verify ggircs:view_facility_details on pg

BEGIN;

select * from swrs.facility_details where false;

ROLLBACK;
