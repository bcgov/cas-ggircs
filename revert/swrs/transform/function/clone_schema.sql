-- Revert ggircs:swrs/transform/function/clone_schema from pg

BEGIN;

DROP FUNCTION clone_schema(text, text, boolean, boolean);

COMMIT;
