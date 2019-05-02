-- Revert ggircs:materialized_view_unit from pg

BEGIN;

drop materialized view ggircs_swrs.unit;

COMMIT;
