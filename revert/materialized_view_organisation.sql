-- Revert ggircs:materialized_view_organisation from pg

BEGIN;

drop materialized view ggircs_swrs.organisation;

COMMIT;
