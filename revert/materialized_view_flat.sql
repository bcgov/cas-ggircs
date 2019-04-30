-- Revert ggircs:materialized_view_flat from pg

BEGIN;

drop materialized view ggircs_swrs.flat;

COMMIT;
