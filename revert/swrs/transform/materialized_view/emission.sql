-- Revert ggircs:materialized_view_emission from pg

begin;

drop materialized view ggircs_swrs_transform.emission;

commit;
