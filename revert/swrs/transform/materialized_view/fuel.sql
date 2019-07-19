-- Revert ggircs:materialized_view_fuel from pg

begin;

drop materialized view ggircs_swrs_transform.fuel;

commit;
