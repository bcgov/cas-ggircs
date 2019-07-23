-- Verify ggircs:swrs/transform/function/clone_schema on pg

BEGIN;

select pg_get_functiondef('swrs_transform.clone_schema(text, text, boolean, boolean)'::regprocedure);

ROLLBACK;
