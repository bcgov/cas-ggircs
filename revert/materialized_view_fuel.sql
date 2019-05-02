-- Revert ggircs:materialized_view_fuel from pg

BEGIN;

drop materialized view ggircs_swrs.fuel;

COMMIT;
