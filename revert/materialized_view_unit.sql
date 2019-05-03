-- Revert ggircs:materialized_view_unit from pg

begin;

drop materialized view ggircs_swrs.unit;

commit;
