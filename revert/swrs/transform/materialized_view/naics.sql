-- Revert ggircs:materialized_view_naics from pg

begin;

drop materialized view ggircs_swrs_transform.naics;

commit;
