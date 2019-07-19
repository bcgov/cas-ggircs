-- Revert ggircs:materialized_view_facility from pg

begin;

drop materialized view ggircs_swrs_transform.facility;

commit;
