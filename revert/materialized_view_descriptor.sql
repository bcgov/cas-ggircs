-- Revert ggircs:materialized_view_descriptors from pg

BEGIN;

drop materialized view ggircs_swrs.descriptor;

COMMIT;
