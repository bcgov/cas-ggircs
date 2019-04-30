-- Revert ggircs:materialized_view_identifier from pg

BEGIN;

drop materialized view ggircs_swrs.identifier;

COMMIT;
