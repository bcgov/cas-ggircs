-- Revert ggircs:materialized_view_unit from pg

begin;

drop materialized view ggircs_swrs_transform.unit;

commit;
