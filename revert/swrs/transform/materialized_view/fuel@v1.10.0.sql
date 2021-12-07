-- Revert ggircs:materialized_view_fuel from pg

begin;

drop materialized view swrs_transform.fuel;

commit;
