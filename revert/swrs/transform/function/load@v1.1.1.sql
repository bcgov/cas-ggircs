-- Revert ggircs:function_load from pg

BEGIN;

 drop function swrs_transform.load;

COMMIT;
