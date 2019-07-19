-- Revert ggircs:function_load_activity from pg

begin;

 drop function ggircs_swrs_transform.load_activity;

commit;
