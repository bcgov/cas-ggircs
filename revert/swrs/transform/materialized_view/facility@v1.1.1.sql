-- Revert ggircs:materialized_view_facility from pg

begin;

drop materialized view swrs_transform.facility;

commit;
