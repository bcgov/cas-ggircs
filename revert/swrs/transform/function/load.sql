-- Revert ggircs:function_load from pg

BEGIN;

 drop function ggircs_swrs_transform.load;

COMMIT;
