-- Revert ggircs:materialized_view_naics from pg

begin;

drop materialized view swrs_transform.naics;

commit;
