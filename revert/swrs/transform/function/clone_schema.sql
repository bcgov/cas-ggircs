-- Revert ggircs:swrs/transform/function/clone_schema from pg

BEGIN;

DROP FUNCTION ggircs_swrs_transform.clone_schema(text, text, boolean, boolean);

COMMIT;
