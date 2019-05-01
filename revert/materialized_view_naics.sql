-- Revert ggircs:materialized_view_naics from pg

BEGIN;

drop materialized view ggircs_swrs.naics;

COMMIT;
