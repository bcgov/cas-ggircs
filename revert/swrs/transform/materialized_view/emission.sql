-- Revert ggircs:materialized_view_emission from pg

begin;

drop materialized view swrs_transform.emission;

commit;
