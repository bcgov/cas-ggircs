-- Revert ggircs:materialized_view_organisation from pg

BEGIN;

drop materialized view swrs_transform.organisation;

COMMIT;
