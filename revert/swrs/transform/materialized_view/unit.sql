-- Revert ggircs:materialized_view_unit from pg

begin;

drop materialized view swrs_transform.unit;

commit;
